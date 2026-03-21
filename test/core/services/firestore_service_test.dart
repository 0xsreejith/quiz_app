import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz_app/core/services/firestore_service.dart';

// ---------- Mocks ----------

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

// ---------- Tests ----------

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockUsersCollection;
  late MockCollectionReference mockScoresCollection;
  late MockDocumentReference mockDocRef;
  late FirestoreService service;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockUsersCollection = MockCollectionReference();
    mockScoresCollection = MockCollectionReference();
    mockDocRef = MockDocumentReference();

    // Register fallback values for mocktail
    registerFallbackValue(<String, dynamic>{});
    registerFallbackValue(SetOptions(merge: true));

    service = FirestoreService(firestore: mockFirestore);
  });

  group('FirestoreService - createUserDocument', () {
    test('accesses the users collection', () async {
      when(() => mockFirestore.collection('users'))
          .thenReturn(mockUsersCollection);
      when(() => mockUsersCollection.doc(any()))
          .thenReturn(mockDocRef);
      when(
        () => mockDocRef.set(any(), any<SetOptions>()),
      ).thenAnswer((_) async {});

      await service.createUserDocument(uid: 'uid1', email: 'a@b.com');

      verify(() => mockFirestore.collection('users')).called(1);
    });

    test('accesses the document with the correct uid', () async {
      when(() => mockFirestore.collection('users'))
          .thenReturn(mockUsersCollection);
      when(() => mockUsersCollection.doc('myuid'))
          .thenReturn(mockDocRef);
      when(
        () => mockDocRef.set(any(), any<SetOptions>()),
      ).thenAnswer((_) async {});

      await service.createUserDocument(uid: 'myuid', email: 'x@y.com');

      verify(() => mockUsersCollection.doc('myuid')).called(1);
    });

    test('calls set with correct uid and email data', () async {
      when(() => mockFirestore.collection('users'))
          .thenReturn(mockUsersCollection);
      when(() => mockUsersCollection.doc(any()))
          .thenReturn(mockDocRef);
      when(
        () => mockDocRef.set(any(), any<SetOptions>()),
      ).thenAnswer((_) async {});

      await service.createUserDocument(uid: 'uid1', email: 'test@test.com');

      final captured = verify(
        () => mockDocRef.set(captureAny(), any<SetOptions>()),
      ).captured;
      final data = captured.first as Map<String, dynamic>;

      expect(data['uid'], 'uid1');
      expect(data['email'], 'test@test.com');
    });

    test('includes uid field in the document data', () async {
      when(() => mockFirestore.collection('users'))
          .thenReturn(mockUsersCollection);
      when(() => mockUsersCollection.doc(any()))
          .thenReturn(mockDocRef);
      when(
        () => mockDocRef.set(any(), any<SetOptions>()),
      ).thenAnswer((_) async {});

      await service.createUserDocument(uid: 'the-uid', email: 'e@test.com');

      final captured = verify(
        () => mockDocRef.set(captureAny(), any<SetOptions>()),
      ).captured;
      expect((captured.first as Map<String, dynamic>)['uid'], 'the-uid');
    });

    test('includes email field in the document data', () async {
      when(() => mockFirestore.collection('users'))
          .thenReturn(mockUsersCollection);
      when(() => mockUsersCollection.doc(any()))
          .thenReturn(mockDocRef);
      when(
        () => mockDocRef.set(any(), any<SetOptions>()),
      ).thenAnswer((_) async {});

      await service.createUserDocument(uid: 'uid2', email: 'email@domain.com');

      final captured = verify(
        () => mockDocRef.set(captureAny(), any<SetOptions>()),
      ).captured;
      expect(
        (captured.first as Map<String, dynamic>)['email'],
        'email@domain.com',
      );
    });

    test('uses merge: true in SetOptions', () async {
      when(() => mockFirestore.collection('users'))
          .thenReturn(mockUsersCollection);
      when(() => mockUsersCollection.doc(any()))
          .thenReturn(mockDocRef);
      when(
        () => mockDocRef.set(any(), any<SetOptions>()),
      ).thenAnswer((_) async {});

      await service.createUserDocument(uid: 'uid3', email: 'merge@test.com');

      final captured = verify(
        () => mockDocRef.set(any(), captureAny<SetOptions>()),
      ).captured;
      final options = captured.first as SetOptions;
      expect(options.merge, isTrue);
    });
  });

  group('FirestoreService - saveScore', () {
    test('adds a document to the scores collection', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(() => mockScoresCollection.add(any()))
          .thenAnswer((_) async => mockDocRef);

      await service.saveScore(uid: 'u1', email: 'u@test.com', score: 80);

      verify(() => mockFirestore.collection('scores')).called(1);
      verify(() => mockScoresCollection.add(any())).called(1);
    });

    test('includes uid in the score data', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(() => mockScoresCollection.add(any()))
          .thenAnswer((_) async => mockDocRef);

      await service.saveScore(uid: 'specific-uid', email: 'u@t.com', score: 70);

      final captured = verify(
        () => mockScoresCollection.add(captureAny()),
      ).captured;
      expect((captured.first as Map<String, dynamic>)['uid'], 'specific-uid');
    });

    test('includes email in the score data', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(() => mockScoresCollection.add(any()))
          .thenAnswer((_) async => mockDocRef);

      await service.saveScore(uid: 'u', email: 'saved@email.com', score: 60);

      final captured = verify(
        () => mockScoresCollection.add(captureAny()),
      ).captured;
      expect(
        (captured.first as Map<String, dynamic>)['email'],
        'saved@email.com',
      );
    });

    test('includes score value in the score data', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(() => mockScoresCollection.add(any()))
          .thenAnswer((_) async => mockDocRef);

      await service.saveScore(uid: 'u', email: 'e@t.com', score: 95);

      final captured = verify(
        () => mockScoresCollection.add(captureAny()),
      ).captured;
      expect((captured.first as Map<String, dynamic>)['score'], 95);
    });

    test('saves a score of 0 correctly', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(() => mockScoresCollection.add(any()))
          .thenAnswer((_) async => mockDocRef);

      await service.saveScore(uid: 'zero-user', email: 'z@t.com', score: 0);

      final captured = verify(
        () => mockScoresCollection.add(captureAny()),
      ).captured;
      expect((captured.first as Map<String, dynamic>)['score'], 0);
    });

    test('saves maximum score correctly', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(() => mockScoresCollection.add(any()))
          .thenAnswer((_) async => mockDocRef);

      await service.saveScore(uid: 'top', email: 'top@t.com', score: 100);

      final captured = verify(
        () => mockScoresCollection.add(captureAny()),
      ).captured;
      expect((captured.first as Map<String, dynamic>)['score'], 100);
    });
  });

  group('FirestoreService - getTopScores', () {
    late MockQuery mockOrderedQuery;
    late MockQuery mockLimitedQuery;
    late MockQuerySnapshot mockSnapshot;

    setUp(() {
      mockOrderedQuery = MockQuery();
      mockLimitedQuery = MockQuery();
      mockSnapshot = MockQuerySnapshot();
    });

    test('queries scores collection ordered by score descending', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(
        () => mockScoresCollection.orderBy('score', descending: true),
      ).thenReturn(mockOrderedQuery);
      when(() => mockOrderedQuery.limit(any())).thenReturn(mockLimitedQuery);
      when(() => mockLimitedQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(() => mockSnapshot.docs).thenReturn([]);

      await service.getTopScores();

      verify(
        () => mockScoresCollection.orderBy('score', descending: true),
      ).called(1);
    });

    test('applies limit to query', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(
        () => mockScoresCollection.orderBy('score', descending: true),
      ).thenReturn(mockOrderedQuery);
      when(() => mockOrderedQuery.limit(5)).thenReturn(mockLimitedQuery);
      when(() => mockLimitedQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(() => mockSnapshot.docs).thenReturn([]);

      await service.getTopScores(limit: 5);

      verify(() => mockOrderedQuery.limit(5)).called(1);
    });

    test('uses default limit of 10', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(
        () => mockScoresCollection.orderBy('score', descending: true),
      ).thenReturn(mockOrderedQuery);
      when(() => mockOrderedQuery.limit(10)).thenReturn(mockLimitedQuery);
      when(() => mockLimitedQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(() => mockSnapshot.docs).thenReturn([]);

      await service.getTopScores();

      verify(() => mockOrderedQuery.limit(10)).called(1);
    });

    test('returns empty list when no documents exist', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(
        () => mockScoresCollection.orderBy('score', descending: true),
      ).thenReturn(mockOrderedQuery);
      when(() => mockOrderedQuery.limit(any())).thenReturn(mockLimitedQuery);
      when(() => mockLimitedQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(() => mockSnapshot.docs).thenReturn([]);

      final result = await service.getTopScores();

      expect(result, isEmpty);
    });

    test('returns data from documents', () async {
      final mockDoc1 = MockQueryDocumentSnapshot();
      final mockDoc2 = MockQueryDocumentSnapshot();

      when(() => mockDoc1.data()).thenReturn({'uid': 'u1', 'score': 90});
      when(() => mockDoc2.data()).thenReturn({'uid': 'u2', 'score': 70});

      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(
        () => mockScoresCollection.orderBy('score', descending: true),
      ).thenReturn(mockOrderedQuery);
      when(() => mockOrderedQuery.limit(any())).thenReturn(mockLimitedQuery);
      when(() => mockLimitedQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(() => mockSnapshot.docs).thenReturn([mockDoc1, mockDoc2]);

      final result = await service.getTopScores();

      expect(result.length, 2);
      expect(result[0]['score'], 90);
      expect(result[1]['score'], 70);
    });

    test('returns a List<Map<String, dynamic>>', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(
        () => mockScoresCollection.orderBy('score', descending: true),
      ).thenReturn(mockOrderedQuery);
      when(() => mockOrderedQuery.limit(any())).thenReturn(mockLimitedQuery);
      when(() => mockLimitedQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(() => mockSnapshot.docs).thenReturn([]);

      final result = await service.getTopScores();

      expect(result, isA<List<Map<String, dynamic>>>());
    });

    // Regression: limit=1 should still work correctly
    test('limit=1 still calls get on the query', () async {
      when(() => mockFirestore.collection('scores'))
          .thenReturn(mockScoresCollection);
      when(
        () => mockScoresCollection.orderBy('score', descending: true),
      ).thenReturn(mockOrderedQuery);
      when(() => mockOrderedQuery.limit(1)).thenReturn(mockLimitedQuery);
      when(() => mockLimitedQuery.get()).thenAnswer((_) async => mockSnapshot);
      when(() => mockSnapshot.docs).thenReturn([]);

      await service.getTopScores(limit: 1);

      verify(() => mockLimitedQuery.get()).called(1);
    });
  });
}