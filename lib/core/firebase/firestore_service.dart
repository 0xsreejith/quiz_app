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
}
