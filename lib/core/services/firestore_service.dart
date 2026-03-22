import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  static const int _scoreQueryLimit = 500;

  final FirebaseFirestore _firestore;

  static GetOptions? _getOptions({required bool forceServer}) {
    return forceServer ? const GetOptions(source: Source.server) : null;
  }

  Future<int> migrateScoresToTotalScore() async {
    final DocumentReference<Map<String, dynamic>> migrationRef = _firestore
        .collection('meta')
        .doc('migrationV2');
    final DocumentSnapshot<Map<String, dynamic>> migrationSnap =
        await migrationRef.get();
    final bool alreadyDone = migrationSnap.data()?['done'] as bool? ?? false;
    if (alreadyDone) {
      return 0;
    }

    final QuerySnapshot<Map<String, dynamic>> scoresSnapshot = await _firestore
        .collection('scores')
        .get();

    WriteBatch batch = _firestore.batch();
    int pendingWrites = 0;
    int migratedCount = 0;

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in scoresSnapshot.docs) {
      final Map<String, dynamic> data = doc.data();
      final bool hasLegacyScore = data.containsKey('score');
      final bool hasTotalScore = data.containsKey('totalScore');
      if (!hasLegacyScore || hasTotalScore) {
        continue;
      }

      final int legacyScore = _readInt(data['score']) ?? 0;
      final Object firstPlayedAt =
          data['updatedAt'] ?? FieldValue.serverTimestamp();

      batch.set(doc.reference, <String, dynamic>{
        'totalScore': legacyScore,
        'totalAttempts': 1,
        'totalCorrect': 0,
        'totalQuestions': 0,
        'avgAccuracy': 0.0,
        'avgCompletionMs': 0,
        'firstPlayedAt': firstPlayedAt,
        'lastUpdatedAt': firstPlayedAt,
        'globalBadge': _calculateGlobalBadge(legacyScore),
      }, SetOptions(merge: true));

      pendingWrites++;
      migratedCount++;

      if (pendingWrites >= 400) {
        await batch.commit();
        batch = _firestore.batch();
        pendingWrites = 0;
      }
    }

    if (pendingWrites > 0) {
      await batch.commit();
    }

    await migrationRef.set(<String, dynamic>{
      'done': true,
      'migratedCount': migratedCount,
      'completedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return migratedCount;
  }

  Future<void> createUserDocument({
    required String uid,
    required String email,
    String? displayName,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef = _firestore
        .collection('users')
        .doc(uid);
    final DocumentSnapshot<Map<String, dynamic>> snapshot = await userRef.get();

    final Map<String, dynamic> data = <String, dynamic>{
      'uid': uid,
      'email': email,
    };

    final String? trimmedDisplayName = _trimOrNull(displayName);
    if (trimmedDisplayName != null) {
      data['displayName'] = trimmedDisplayName;
    }

    if (!snapshot.exists) {
      data.addAll(<String, dynamic>{
        'createdAt': FieldValue.serverTimestamp(),
        'totalPlayed': 0,
        'bestScore': 0,
        'avgAccuracy': 0,
        'totalScore': 0,
        'globalBadge': 'unranked',
        'earnedBadges': <String>[],
      });
    }

    await userRef.set(data, SetOptions(merge: true));
  }

  /// Called after every quiz completion. Adds [earnedScore] to the user's
  /// cumulative total and recalculates the leaderboard fields.
  Future<void> saveScore({
    required String uid,
    required String email,
    required int earnedScore,
    required int correctAnswers,
    required int totalQuestions,
    required int completionMs,
    String? displayName,
  }) async {
    final DocumentReference<Map<String, dynamic>> ref = _firestore
        .collection('scores')
        .doc(uid);

    await _firestore.runTransaction((Transaction tx) async {
      final DocumentSnapshot<Map<String, dynamic>> snap = await tx.get(ref);
      final Map<String, dynamic> data = snap.data() ?? <String, dynamic>{};

      final int prevTotal =
          _readInt(data['totalScore']) ?? _readInt(data['score']) ?? 0;
      final int prevAttempts = _readInt(data['totalAttempts']) ?? 0;
      final int prevCorrect = _readInt(data['totalCorrect']) ?? 0;
      final int prevTotalQuestions = _readInt(data['totalQuestions']) ?? 0;
      final int prevAvgMs = _readInt(data['avgCompletionMs']) ?? 0;

      final int newTotal = prevTotal + earnedScore;
      final int newAttempts = prevAttempts + 1;
      final int newCorrect = prevCorrect + correctAnswers;
      final int newTotalQuestions = prevTotalQuestions + totalQuestions;
      final double newAvgAccuracy = newTotalQuestions > 0
          ? (newCorrect / newTotalQuestions) * 100
          : 0;
      final int newAvgMs = prevAttempts == 0
          ? completionMs
          : ((prevAvgMs * prevAttempts) + completionMs) ~/ newAttempts;

      final Map<String, dynamic> updateData = <String, dynamic>{
        'uid': uid,
        'email': email,
        'score': newTotal,
        'totalScore': newTotal,
        'totalAttempts': newAttempts,
        'totalCorrect': newCorrect,
        'totalQuestions': newTotalQuestions,
        'avgAccuracy': newAvgAccuracy,
        'avgCompletionMs': newAvgMs,
        'lastUpdatedAt': FieldValue.serverTimestamp(),
        'globalBadge': _calculateGlobalBadge(newTotal),
      };

      final String? trimmedDisplayName = _trimOrNull(displayName);
      if (trimmedDisplayName != null) {
        updateData['displayName'] = trimmedDisplayName;
      }

      if (!snap.exists) {
        updateData['firstPlayedAt'] = FieldValue.serverTimestamp();
      }

      tx.set(ref, updateData, SetOptions(merge: true));
    });

    await _syncUserDocFromScoreDoc(uid: uid);
  }

  Future<List<Map<String, dynamic>>> getTopScores({
    int limit = 10,
    bool forceServer = false,
  }) async {
    return _getUniqueScores(limit: limit, forceServer: forceServer);
  }

  /// Fetches the entire sorted scores list ONCE and derives all leaderboard
  /// values from that single list: top-N for display, user rank, user score
  /// doc, and total ranked count. This guarantees rank == position in list.
  ///
  /// If the signed-in user is not in the top query window (e.g. new or low
  /// score), their `scores/{uid}` document is merged in so profile / "Your
  /// position" still reflect their real totals.
  Future<Map<String, dynamic>> getLeaderboardBundle({
    required String uid,
    int displayLimit = 50,
    bool forceServer = false,
  }) async {
    final GetOptions? options = _getOptions(forceServer: forceServer);
    List<Map<String, dynamic>> allScores = await _getUniqueScores(
      forceServer: forceServer,
    );

    int userIndex = allScores.indexWhere(
      (Map<String, dynamic> s) => s['uid'] == uid || s['docId'] == uid,
    );

    if (userIndex == -1) {
      final DocumentSnapshot<Map<String, dynamic>> snap = await _firestore
          .collection('scores')
          .doc(uid)
          .get(options);
      if (snap.exists) {
        final Map<String, dynamic> normalized = _normalizeScoreDoc(
          snap.data()!,
          fallbackUid: uid,
        );
        allScores = <Map<String, dynamic>>[...allScores, normalized]
          ..sort(_compareScoreDocs);
        userIndex = allScores.indexWhere(
          (Map<String, dynamic> s) => s['uid'] == uid || s['docId'] == uid,
        );
      }
    }

    final int userRank = userIndex == -1 ? 0 : userIndex + 1;
    final Map<String, dynamic>? userScoreDoc = userIndex == -1
        ? null
        : allScores[userIndex];

    final List<Map<String, dynamic>> topScores = allScores.length > displayLimit
        ? allScores.sublist(0, displayLimit)
        : List<Map<String, dynamic>>.from(allScores);

    return <String, dynamic>{
      'topScores': topScores,
      'userScoreDoc': userScoreDoc,
      'userRank': userRank,
      'totalRanked': allScores.length,
    };
  }

  /// Returns leaderboard display data from a single underlying fetch.
  Future<Map<String, dynamic>> getLeaderboardData({
    required String uid,
    int displayLimit = 50,
  }) async {
    return getLeaderboardBundle(uid: uid, displayLimit: displayLimit);
  }

  /// Fetch the signed-in user's own score document directly.
  Future<Map<String, dynamic>?> getUserScoreDoc(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snap = await _firestore
        .collection('scores')
        .doc(uid)
        .get();
    if (snap.exists) {
      return _normalizeScoreDoc(snap.data()!, fallbackUid: uid);
    }

    final List<Map<String, dynamic>> uniqueScores = await _getUniqueScores();
    for (final Map<String, dynamic> score in uniqueScores) {
      if (score['uid'] == uid || score['docId'] == uid) {
        return score;
      }
    }
    return null;
  }

  /// Count users scoring strictly higher with tie-breakers applied.
  Future<int> getUserGlobalRank(String uid) async {
    final List<Map<String, dynamic>> uniqueScores = await _getUniqueScores();
    final int index = uniqueScores.indexWhere(
      (Map<String, dynamic> score) =>
          score['uid'] == uid || score['docId'] == uid,
    );
    if (index == -1) return 0;
    return index + 1;
  }

  Future<int> getRankedUserCount() async {
    final List<Map<String, dynamic>> uniqueScores = await _getUniqueScores();
    return uniqueScores.length;
  }

  Future<void> saveCategoryScore({
    required String uid,
    required int categoryId,
    required String categoryName,
    required String categoryEmoji,
    required int score, // earned points (stored for display)
    required int correctAnswers, // raw correct count (used for badge)
    required int totalQuestions,
  }) async {
    final DocumentReference<Map<String, dynamic>> ref = _firestore
        .collection('users')
        .doc(uid)
        .collection('categoryScores')
        .doc(categoryId.toString());

    final DocumentSnapshot<Map<String, dynamic>> snapshot = await ref.get();
    final int currentMax = snapshot.exists
        ? (snapshot.data()?['maxScore'] as int? ?? 0)
        : 0;
    final int attempts = snapshot.exists
        ? (snapshot.data()?['totalAttempts'] as int? ?? 0)
        : 0;

    final int newMax = score > currentMax ? score : currentMax;
    // Use accuracy (correct/total) not points/total for badge threshold.
    final String badge = _calculateBadge(correctAnswers, totalQuestions);

    await ref.set(<String, dynamic>{
      'categoryId': categoryId,
      'categoryName': categoryName,
      'categoryEmoji': categoryEmoji,
      'maxScore': newMax,
      'totalAttempts': attempts + 1,
      'lastPlayedAt': FieldValue.serverTimestamp(),
      'badge': badge,
    }, SetOptions(merge: true));
  }

  String _calculateBadge(int correctAnswers, int totalQuestions) {
    if (totalQuestions == 0) return 'none';
    final double percent = correctAnswers / totalQuestions;
    if (percent >= 0.9) return 'gold';
    if (percent >= 0.7) return 'silver';
    if (percent >= 0.5) return 'bronze';
    return 'none';
  }

  String _calculateGlobalBadge(int totalScore) {
    if (totalScore >= 5000) return 'quiz_god';
    if (totalScore >= 2500) return 'quiz_legend';
    if (totalScore >= 1000) return 'quiz_champion';
    if (totalScore >= 500) return 'quiz_master';
    if (totalScore >= 250) return 'quiz_expert';
    if (totalScore >= 100) return 'quiz_scholar';
    if (totalScore >= 50) return 'quiz_apprentice';
    if (totalScore >= 10) return 'quiz_novice';
    return 'unranked';
  }

  List<String> _calculateEarnedBadges({
    required int totalScore,
    required int totalPlayed,
    required double avgAccuracy,
  }) {
    final List<String> badges = <String>[];

    if (totalScore >= 5000) badges.add('quiz_god');
    if (totalScore >= 2500) badges.add('quiz_legend');
    if (totalScore >= 1000) badges.add('quiz_champion');
    if (totalScore >= 500) badges.add('quiz_master');
    if (totalScore >= 250) badges.add('quiz_expert');
    if (totalScore >= 100) badges.add('quiz_scholar');
    if (totalScore >= 50) badges.add('quiz_apprentice');
    if (totalScore >= 10) badges.add('quiz_novice');

    if (totalPlayed >= 100) badges.add('centurion_100');
    if (totalPlayed >= 50) badges.add('elite_50');
    if (totalPlayed >= 25) badges.add('veteran_25');
    if (totalPlayed >= 10) badges.add('committed_10');
    if (totalPlayed >= 5) badges.add('dedicated_5');
    if (totalPlayed >= 1) badges.add('first_attempt');

    if (avgAccuracy >= 90) badges.add('perfectionist');
    if (avgAccuracy >= 80) badges.add('precision_80');
    if (avgAccuracy >= 70) badges.add('sharp_mind');

    return badges;
  }

  Future<List<Map<String, dynamic>>> getCategoryScores(
    String uid, {
    bool forceServer = false,
  }) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('categoryScores')
        .orderBy('maxScore', descending: true)
        .get(forceServer ? const GetOptions(source: Source.server) : null);

    return snapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();
  }

  Future<void> saveQuizHistory({
    required String uid,
    required String categoryName,
    required String categoryEmoji,
    required int score,
    required int totalQuestions,
    required int correctAnswers,
  }) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('quizHistory')
        .add(<String, dynamic>{
          'categoryName': categoryName,
          'categoryEmoji': categoryEmoji,
          'score': score,
          'totalQuestions': totalQuestions,
          'correctAnswers': correctAnswers,
          'accuracy': totalQuestions == 0
              ? 0
              : (correctAnswers / totalQuestions * 100).round(),
          'playedAt': FieldValue.serverTimestamp(),
        });
  }

  Future<List<Map<String, dynamic>>> getQuizHistory(
    String uid, {
    bool forceServer = false,
  }) async {
    final GetOptions? options = _getOptions(forceServer: forceServer);
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('quizHistory')
        .orderBy('playedAt', descending: true)
        .limit(20)
        .get(options);
    return snapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();
  }

  Future<Map<String, dynamic>> getUserStats(
    String uid, {
    bool forceServer = false,
  }) async {
    final GetOptions? options = _getOptions(forceServer: forceServer);
    final List<DocumentSnapshot<Map<String, dynamic>>> snapshots =
        await Future.wait<DocumentSnapshot<Map<String, dynamic>>>([
          _firestore.collection('users').doc(uid).get(options),
          _firestore.collection('scores').doc(uid).get(options),
        ]);

    final DocumentSnapshot<Map<String, dynamic>> userSnap = snapshots[0];
    final DocumentSnapshot<Map<String, dynamic>> scoreSnap = snapshots[1];

    if (!userSnap.exists && !scoreSnap.exists) {
      return <String, dynamic>{
        'totalPlayed': 0,
        'bestScore': 0,
        'avgAccuracy': 0,
        'totalScore': 0,
        'globalBadge': 'unranked',
        'earnedBadges': <String>[],
      };
    }

    final Map<String, dynamic> userData =
        userSnap.data() ?? const <String, dynamic>{};
    final Map<String, dynamic> scoreData =
        scoreSnap.data() ?? const <String, dynamic>{};

    final bool hasScoreDoc = scoreSnap.exists;
    final int totalPlayed = hasScoreDoc
        ? _readInt(scoreData['totalAttempts']) ?? 0
        : _readInt(userData['totalPlayed']) ?? 0;
    final int totalScore = hasScoreDoc
        ? _readInt(scoreData['totalScore']) ??
              _readInt(scoreData['score']) ??
              _readInt(userData['totalScore']) ??
              _readInt(userData['bestScore']) ??
              0
        : _readInt(userData['totalScore']) ??
              _readInt(userData['bestScore']) ??
              0;
    final int totalCorrect = _readInt(scoreData['totalCorrect']) ?? 0;
    final int totalQuestions = _readInt(scoreData['totalQuestions']) ?? 0;
    final double avgAccuracyRaw = hasScoreDoc
        ? scoreData['avgAccuracy'] is num
              ? (scoreData['avgAccuracy'] as num).toDouble()
              : totalQuestions > 0
              ? (totalCorrect / totalQuestions) * 100
              : _readDouble(userData['avgAccuracy'])
        : _readDouble(userData['avgAccuracy']);
    final int avgAccuracy = avgAccuracyRaw.round();
    final int bestScore =
        _readInt(userData['bestScore']) ?? (totalPlayed <= 1 ? totalScore : 0);
    final List<String> earnedBadges = _readStringList(userData['earnedBadges']);
    final String globalBadge =
        scoreData['globalBadge'] as String? ??
        userData['globalBadge'] as String? ??
        _calculateGlobalBadge(totalScore);

    return <String, dynamic>{
      'totalPlayed': totalPlayed,
      'bestScore': bestScore,
      'avgAccuracy': avgAccuracy,
      'totalScore': totalScore,
      'globalBadge': globalBadge,
      'earnedBadges': earnedBadges.isNotEmpty
          ? earnedBadges
          : _calculateEarnedBadges(
              totalScore: totalScore,
              totalPlayed: totalPlayed,
              avgAccuracy: avgAccuracyRaw,
            ),
    };
  }

  /// Reads the authoritative stats from 'scores/{uid}' and mirrors them
  /// into 'users/{uid}' so that ProfileController (which reads users/)
  /// always reflects the same values as the leaderboard (which reads scores/).
  Future<void> _syncUserDocFromScoreDoc({required String uid}) async {
    try {
      final List<DocumentSnapshot<Map<String, dynamic>>> snapshots =
          await Future.wait<DocumentSnapshot<Map<String, dynamic>>>([
            _firestore.collection('scores').doc(uid).get(),
            _firestore.collection('users').doc(uid).get(),
          ]);

      final DocumentSnapshot<Map<String, dynamic>> scoreSnap = snapshots[0];
      final DocumentSnapshot<Map<String, dynamic>> userSnap = snapshots[1];
      if (!scoreSnap.exists) return;

      final Map<String, dynamic> scoreData = scoreSnap.data()!;
      final Map<String, dynamic> userData =
          userSnap.data() ?? const <String, dynamic>{};
      final int totalScore =
          _readInt(scoreData['totalScore']) ??
          _readInt(scoreData['score']) ??
          0;
      final int totalAttempts = _readInt(scoreData['totalAttempts']) ?? 0;
      final int totalCorrect = _readInt(scoreData['totalCorrect']) ?? 0;
      final int totalQuestions = _readInt(scoreData['totalQuestions']) ?? 0;
      final double avgAccuracy = scoreData['avgAccuracy'] is num
          ? (scoreData['avgAccuracy'] as num).toDouble()
          : totalQuestions > 0
          ? (totalCorrect / totalQuestions) * 100
          : 0.0;

      final List<String> earnedBadges = _calculateEarnedBadges(
        totalScore: totalScore,
        totalPlayed: totalAttempts,
        avgAccuracy: avgAccuracy,
      );
      final int existingBestScore = _readInt(userData['bestScore']) ?? 0;
      final int bestScore = existingBestScore > 0
          ? existingBestScore
          : (totalAttempts <= 1 ? totalScore : 0);

      await _firestore.collection('users').doc(uid).set(<String, dynamic>{
        'totalPlayed': totalAttempts,
        'totalScore': totalScore,
        'bestScore': bestScore,
        'avgAccuracy': avgAccuracy.round(),
        'globalBadge': _calculateGlobalBadge(totalScore),
        'earnedBadges': earnedBadges,
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('_syncUserDocFromScoreDoc error: $e');
    }
  }

  Future<List<Map<String, dynamic>>> _getUniqueScores({
    int? limit,
    bool forceServer = false,
  }) async {
    final int fetchLimit = limit == null
        ? _scoreQueryLimit
        : (limit * 5).clamp(limit, _scoreQueryLimit);

    try {
      // Always order by totalScore. The startup migration guarantees
      // every document in `scores/` has this field. The old two-query
      // heuristic caused random sort order when the first document
      // happened to be an unmigrated doc.
      final GetOptions? options = _getOptions(forceServer: forceServer);
      final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
          .collection('scores')
          .orderBy('totalScore', descending: true)
          .limit(fetchLimit)
          .get(options);

      final List<Map<String, dynamic>> uniqueScores = _collectUniqueScores(
        snapshot.docs,
      )..sort(_compareScoreDocs);

      if (limit != null && uniqueScores.length > limit) {
        return uniqueScores.sublist(0, limit);
      }
      return uniqueScores;
    } on FirebaseException {
      rethrow;
    }
  }

  Map<String, dynamic> _normalizeScoreDoc(
    Map<String, dynamic> data, {
    required String fallbackUid,
  }) {
    final String uid = _trimOrNull(data['uid']?.toString()) ?? fallbackUid;
    final int totalScore =
        _readInt(data['totalScore']) ?? _readInt(data['score']) ?? 0;
    final int totalAttempts = _readInt(data['totalAttempts']) ?? 0;
    final int totalCorrect = _readInt(data['totalCorrect']) ?? 0;
    final int totalQuestions = _readInt(data['totalQuestions']) ?? 0;
    final double avgAccuracy = data['avgAccuracy'] is num
        ? (data['avgAccuracy'] as num).toDouble()
        : totalQuestions > 0
        ? (totalCorrect / totalQuestions) * 100
        : 0;
    final Object? firstPlayedAt =
        data['firstPlayedAt'] ?? data['updatedAt'] ?? data['lastUpdatedAt'];

    final Map<String, dynamic> normalized = <String, dynamic>{
      ...data,
      'docId': fallbackUid,
      'uid': uid,
      'totalScore': totalScore,
      'totalAttempts': totalAttempts,
      'totalCorrect': totalCorrect,
      'totalQuestions': totalQuestions,
      'avgAccuracy': avgAccuracy,
      'avgCompletionMs': _readInt(data['avgCompletionMs']) ?? 0,
      'globalBadge':
          data['globalBadge'] as String? ?? _calculateGlobalBadge(totalScore),
    };
    if (firstPlayedAt != null) {
      normalized['firstPlayedAt'] = firstPlayedAt;
    }
    return normalized;
  }

  List<Map<String, dynamic>> _collectUniqueScores(
    Iterable<QueryDocumentSnapshot<Map<String, dynamic>>> docs,
  ) {
    final Map<String, Map<String, dynamic>> userBestScores =
        <String, Map<String, dynamic>>{};

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc in docs) {
      final Map<String, dynamic> normalized = _normalizeScoreDoc(
        doc.data(),
        fallbackUid: doc.id,
      );

      // Use email as primary key for uniqueness, fallback to uid or docId.
      String userKey = (normalized['email'] as String? ?? '')
          .trim()
          .toLowerCase();
      if (userKey.isEmpty) {
        userKey = (normalized['uid'] as String? ?? '').trim();
        if (userKey.isEmpty) {
          userKey = doc.id;
        }
      }

      final Map<String, dynamic>? existing = userBestScores[userKey];
      if (existing == null || _compareScoreDocs(normalized, existing) > 0) {
        userBestScores[userKey] = normalized;
      }
    }

    return userBestScores.values.toList();
  }

  int _compareScoreDocs(Map<String, dynamic> a, Map<String, dynamic> b) {
    final int aScore = _readInt(a['totalScore']) ?? 0;
    final int bScore = _readInt(b['totalScore']) ?? 0;
    final int scoreCompare = bScore.compareTo(aScore);
    if (scoreCompare != 0) {
      return scoreCompare;
    }

    final double aAccuracy = a['avgAccuracy'] is num
        ? (a['avgAccuracy'] as num).toDouble()
        : 0.0;
    final double bAccuracy = b['avgAccuracy'] is num
        ? (b['avgAccuracy'] as num).toDouble()
        : 0.0;
    final int accuracyCompare = bAccuracy.compareTo(aAccuracy);
    if (accuracyCompare != 0) {
      return accuracyCompare;
    }

    final int aAttempts = _readInt(a['totalAttempts']) ?? 0;
    final int bAttempts = _readInt(b['totalAttempts']) ?? 0;
    final int attemptsCompare = aAttempts.compareTo(bAttempts);
    if (attemptsCompare != 0) {
      return attemptsCompare;
    }

    final String aEmail = (a['email'] as String? ?? '').trim().toLowerCase();
    final String bEmail = (b['email'] as String? ?? '').trim().toLowerCase();
    if (aEmail.isNotEmpty && bEmail.isNotEmpty) {
      return aEmail.compareTo(bEmail);
    }

    final String aUid = (a['uid'] as String? ?? '').trim();
    final String bUid = (b['uid'] as String? ?? '').trim();
    return aUid.compareTo(bUid);
  }

  int? _readInt(Object? value) {
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  double _readDouble(Object? value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0;
    return 0;
  }

  List<String> _readStringList(Object? value) {
    if (value is List) {
      return value.whereType<String>().toList();
    }
    return <String>[];
  }

  String? _trimOrNull(String? value) {
    if (value == null) return null;
    final String trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }
}
