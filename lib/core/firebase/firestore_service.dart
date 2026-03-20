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
}
