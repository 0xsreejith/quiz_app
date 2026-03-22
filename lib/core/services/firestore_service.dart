import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

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

      final Object? firstPlayedAt =
          data['firstPlayedAt'] ?? data['updatedAt'] ?? data['lastUpdatedAt'];
      if (firstPlayedAt != null) {
        updateData['firstPlayedAt'] = firstPlayedAt;
      } else {
        updateData['firstPlayedAt'] = FieldValue.serverTimestamp();
      }

      tx.set(ref, updateData, SetOptions(merge: true));
    });
  }

  Future<List<Map<String, dynamic>>> getTopScores({int limit = 10}) async {
    return _getUniqueScores(limit: limit);
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
      if (score['uid'] == uid) {
        return score;
      }
    }
    return null;
  }

  /// Count users scoring strictly higher with tie-breakers applied.
  Future<int> getUserGlobalRank(String uid) async {
    final List<Map<String, dynamic>> uniqueScores = await _getUniqueScores();
    final int index = uniqueScores.indexWhere(
      (Map<String, dynamic> score) => score['uid'] == uid,
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
    required int score,
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
    final String badge = _calculateBadge(newMax, totalQuestions);

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

  String _calculateBadge(int maxScore, int totalQuestions) {
    if (totalQuestions == 0) return 'none';
    final double percent = maxScore / totalQuestions;
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

  Future<List<Map<String, dynamic>>> getCategoryScores(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('categoryScores')
        .orderBy('maxScore', descending: true)
        .get();

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

    await _updateUserStats(
      uid: uid,
      newScore: score,
      newAccuracy: totalQuestions == 0
          ? 0
          : (correctAnswers / totalQuestions * 100).round(),
      earnedScore: score,
    );
  }

  Future<List<Map<String, dynamic>>> getQuizHistory(String uid) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('users')
        .doc(uid)
        .collection('quizHistory')
        .orderBy('playedAt', descending: true)
        .limit(20)
        .get();
    return snapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();
  }

  Future<Map<String, dynamic>> getUserStats(String uid) async {
    final DocumentSnapshot<Map<String, dynamic>> snap = await _firestore
        .collection('users')
        .doc(uid)
        .get();
    if (!snap.exists) {
      return <String, dynamic>{
        'totalPlayed': 0,
        'bestScore': 0,
        'avgAccuracy': 0,
        'totalScore': 0,
        'globalBadge': 'unranked',
        'earnedBadges': <String>[],
      };
    }

    final Map<String, dynamic> data = snap.data()!;
    final int totalPlayed = _readInt(data['totalPlayed']) ?? 0;
    final int bestScore = _readInt(data['bestScore']) ?? 0;
    final int avgAccuracy = _readDouble(data['avgAccuracy']).round();
    final int totalScore =
        _readInt(data['totalScore']) ?? _readInt(data['bestScore']) ?? 0;
    final List<String> earnedBadges = _readStringList(data['earnedBadges']);

    return <String, dynamic>{
      'totalPlayed': totalPlayed,
      'bestScore': bestScore,
      'avgAccuracy': avgAccuracy,
      'totalScore': totalScore,
      'globalBadge':
          data['globalBadge'] as String? ?? _calculateGlobalBadge(totalScore),
      'earnedBadges': earnedBadges.isNotEmpty
          ? earnedBadges
          : _calculateEarnedBadges(
              totalScore: totalScore,
              totalPlayed: totalPlayed,
              avgAccuracy: avgAccuracy.toDouble(),
            ),
    };
  }

  Future<void> _updateUserStats({
    required String uid,
    required int newScore,
    required int newAccuracy,
    required int earnedScore,
  }) async {
    final DocumentReference<Map<String, dynamic>> ref = _firestore
        .collection('users')
        .doc(uid);

    await _firestore.runTransaction((Transaction tx) async {
      final DocumentSnapshot<Map<String, dynamic>> snap = await tx.get(ref);
      final Map<String, dynamic> data = snap.data() ?? <String, dynamic>{};

      final int prevPlayed = _readInt(data['totalPlayed']) ?? 0;
      final int prevBest = _readInt(data['bestScore']) ?? 0;
      final double prevAvg = _readDouble(data['avgAccuracy']);
      final int prevTotalScore =
          _readInt(data['totalScore']) ?? _readInt(data['bestScore']) ?? 0;

      final int newTotalPlayed = prevPlayed + 1;
      final int newBest = newScore > prevBest ? newScore : prevBest;
      final double newAvg =
          ((prevAvg * prevPlayed) + newAccuracy) / newTotalPlayed;
      final int newTotalScore = prevTotalScore + earnedScore;

      final List<String> storedEarnedBadges = _readStringList(
        data['earnedBadges'],
      );
      final List<String> previousEarnedBadges = storedEarnedBadges.isNotEmpty
          ? storedEarnedBadges
          : _calculateEarnedBadges(
              totalScore: prevTotalScore,
              totalPlayed: prevPlayed,
              avgAccuracy: prevAvg,
            );
      final List<String> earnedBadges = _calculateEarnedBadges(
        totalScore: newTotalScore,
        totalPlayed: newTotalPlayed,
        avgAccuracy: newAvg,
      );

      final Map<String, dynamic> updateData = <String, dynamic>{
        'totalPlayed': newTotalPlayed,
        'bestScore': newBest,
        'avgAccuracy': newAvg.round(),
        'totalScore': newTotalScore,
        'globalBadge': _calculateGlobalBadge(newTotalScore),
        'earnedBadges': earnedBadges,
      };

      final bool earnedNewBadge = earnedBadges.any(
        (String badge) => !previousEarnedBadges.contains(badge),
      );
      if (earnedNewBadge) {
        updateData['lastBadgeEarnedAt'] = FieldValue.serverTimestamp();
      }

      tx.set(ref, updateData, SetOptions(merge: true));
    });
  }

  Future<List<Map<String, dynamic>>> _getUniqueScores({int? limit}) async {
    Query<Map<String, dynamic>> query = _firestore
        .collection('scores')
        .orderBy('totalScore', descending: true)
        .orderBy('avgAccuracy', descending: true)
        .orderBy('avgCompletionMs')
        .orderBy('firstPlayedAt');

    if (limit != null) {
      query = query.limit(limit);
    }

    final QuerySnapshot<Map<String, dynamic>> snapshot = await query.get();
    final List<Map<String, dynamic>> uniqueScores = <Map<String, dynamic>>[];
    final Set<String> seenUsers = <String>{};

    for (final QueryDocumentSnapshot<Map<String, dynamic>> doc
        in snapshot.docs) {
      final Map<String, dynamic> normalized = _normalizeScoreDoc(
        doc.data(),
        fallbackUid: doc.id,
      );
      final String uid = (normalized['uid'] as String? ?? '').trim();
      final String email = (normalized['email'] as String? ?? '').trim();
      final String userKey = uid.isNotEmpty
          ? uid
          : email.isNotEmpty
          ? email
          : doc.id;

      if (seenUsers.contains(userKey)) {
        continue;
      }

      seenUsers.add(userKey);
      uniqueScores.add(normalized);
    }

    return uniqueScores;
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
