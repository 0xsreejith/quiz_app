import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<void> createUserDocument({
    required String uid,
    required String email,
  }) async {
    final DocumentReference<Map<String, dynamic>> userRef = _firestore
        .collection('users')
        .doc(uid);

    await userRef.set(<String, dynamic>{
      'uid': uid,
      'email': email,
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  Future<void> saveScore({
    required String uid,
    required String email,
    required int score,
  }) async {
    await _firestore.collection('scores').add(<String, dynamic>{
      'uid': uid,
      'email': email,
      'score': score,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<List<Map<String, dynamic>>> getTopScores({int limit = 10}) async {
    final QuerySnapshot<Map<String, dynamic>> snapshot = await _firestore
        .collection('scores')
        .orderBy('score', descending: true)
        .limit(limit)
        .get();

    return snapshot.docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> doc) => doc.data())
        .toList();
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
    final double percent = maxScore / totalQuestions;
    if (percent >= 0.9) return 'gold';
    if (percent >= 0.7) return 'silver';
    if (percent >= 0.5) return 'bronze';
    return 'none';
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
      'accuracy': (correctAnswers / totalQuestions * 100).round(),
      'playedAt': FieldValue.serverTimestamp(),
    });

    await _updateUserStats(
      uid: uid,
      newScore: score,
      newAccuracy: (correctAnswers / totalQuestions * 100).round(),
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
    final DocumentSnapshot<Map<String, dynamic>> snap =
        await _firestore.collection('users').doc(uid).get();
    if (!snap.exists) {
      return <String, dynamic>{
        'totalPlayed': 0,
        'bestScore': 0,
        'avgAccuracy': 0,
      };
    }
    final Map<String, dynamic> data = snap.data()!;
    return <String, dynamic>{
      'totalPlayed': data['totalPlayed'] as int? ?? 0,
      'bestScore': data['bestScore'] as int? ?? 0,
      'avgAccuracy': data['avgAccuracy'] as int? ?? 0,
    };
  }

  Future<void> _updateUserStats({
    required String uid,
    required int newScore,
    required int newAccuracy,
  }) async {
    final DocumentReference<Map<String, dynamic>> ref =
        _firestore.collection('users').doc(uid);
    await _firestore.runTransaction((Transaction tx) async {
      final DocumentSnapshot<Map<String, dynamic>> snap = await tx.get(ref);
      final Map<String, dynamic> data = snap.data() ?? <String, dynamic>{};
      final int prevPlayed = data['totalPlayed'] as int? ?? 0;
      final int prevBest = data['bestScore'] as int? ?? 0;
      final double prevAvg =
          (data['avgAccuracy'] as num?)?.toDouble() ?? 0;
      final int newTotal = prevPlayed + 1;
      final int newBest = newScore > prevBest ? newScore : prevBest;
      final double newAvg =
          ((prevAvg * prevPlayed) + newAccuracy) / newTotal;
      tx.set(
        ref,
        <String, dynamic>{
          'totalPlayed': newTotal,
          'bestScore': newBest,
          'avgAccuracy': newAvg.round(),
        },
        SetOptions(merge: true),
      );
    });
  }
}
