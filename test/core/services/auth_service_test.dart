import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:quiz_app/core/services/auth_service.dart';

// ---------- Fakes & Mocks ----------

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockUser extends Mock implements User {}

class MockUserCredential extends Mock implements UserCredential {}

class MockUserInfo extends Mock implements UserInfo {}

// ---------- Tests ----------

void main() {
  late MockFirebaseAuth mockAuth;
  late AuthService service;
  late MockUser mockUser;
  late MockUserCredential mockCredential;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockUser = MockUser();
    mockCredential = MockUserCredential();

    when(() => mockCredential.user).thenReturn(mockUser);
    service = AuthService(firebaseAuth: mockAuth);
  });

  group('AuthService - currentUser', () {
    test('returns null when no user is signed in', () {
      when(() => mockAuth.currentUser).thenReturn(null);
      expect(service.currentUser, isNull);
    });

    test('returns the user when signed in', () {
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.uid).thenReturn('uid123');
      expect(service.currentUser, mockUser);
    });

    test('delegates to FirebaseAuth.currentUser', () {
      when(() => mockAuth.currentUser).thenReturn(null);
      service.currentUser;
      verify(() => mockAuth.currentUser).called(1);
    });
  });

  group('AuthService - authStateChanges', () {
    test('returns a Stream<User?>', () {
      when(() => mockAuth.authStateChanges())
          .thenAnswer((_) => const Stream.empty());
      expect(service.authStateChanges(), isA<Stream<User?>>());
    });

    test('delegates to FirebaseAuth.authStateChanges', () {
      when(() => mockAuth.authStateChanges())
          .thenAnswer((_) => const Stream.empty());
      service.authStateChanges();
      verify(() => mockAuth.authStateChanges()).called(1);
    });

    test('emits null when stream is empty', () async {
      when(() => mockAuth.authStateChanges())
          .thenAnswer((_) => Stream.value(null));
      final user = await service.authStateChanges().first;
      expect(user, isNull);
    });

    test('emits user when user is present', () async {
      when(() => mockAuth.authStateChanges())
          .thenAnswer((_) => Stream.value(mockUser));
      final user = await service.authStateChanges().first;
      expect(user, mockUser);
    });
  });

  group('AuthService - signInWithEmailAndPassword', () {
    test('delegates to FirebaseAuth', () async {
      when(
        () => mockAuth.signInWithEmailAndPassword(
          email: 'test@test.com',
          password: 'pass',
        ),
      ).thenAnswer((_) async => mockCredential);

      final result = await service.signInWithEmailAndPassword(
        email: 'test@test.com',
        password: 'pass',
      );

      expect(result, mockCredential);
    });

    test('calls FirebaseAuth with correct email and password', () async {
      when(
        () => mockAuth.signInWithEmailAndPassword(
          email: 'user@example.com',
          password: 'mypassword',
        ),
      ).thenAnswer((_) async => mockCredential);

      await service.signInWithEmailAndPassword(
        email: 'user@example.com',
        password: 'mypassword',
      );

      verify(
        () => mockAuth.signInWithEmailAndPassword(
          email: 'user@example.com',
          password: 'mypassword',
        ),
      ).called(1);
    });

    test('propagates FirebaseAuthException on invalid credentials', () async {
      when(
        () => mockAuth.signInWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        FirebaseAuthException(code: 'wrong-password'),
      );

      expect(
        () async => service.signInWithEmailAndPassword(
          email: 'bad@test.com',
          password: 'wrong',
        ),
        throwsA(isA<FirebaseAuthException>()),
      );
    });
  });

  group('AuthService - createUserWithEmailAndPassword', () {
    test('delegates to FirebaseAuth', () async {
      when(
        () => mockAuth.createUserWithEmailAndPassword(
          email: 'new@test.com',
          password: 'newpass',
        ),
      ).thenAnswer((_) async => mockCredential);

      final result = await service.createUserWithEmailAndPassword(
        email: 'new@test.com',
        password: 'newpass',
      );

      expect(result, mockCredential);
    });

    test('calls FirebaseAuth with correct email and password', () async {
      when(
        () => mockAuth.createUserWithEmailAndPassword(
          email: 'create@test.com',
          password: 'createpass',
        ),
      ).thenAnswer((_) async => mockCredential);

      await service.createUserWithEmailAndPassword(
        email: 'create@test.com',
        password: 'createpass',
      );

      verify(
        () => mockAuth.createUserWithEmailAndPassword(
          email: 'create@test.com',
          password: 'createpass',
        ),
      ).called(1);
    });

    test('propagates FirebaseAuthException on duplicate email', () async {
      when(
        () => mockAuth.createUserWithEmailAndPassword(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenThrow(
        FirebaseAuthException(code: 'email-already-in-use'),
      );

      expect(
        () async => service.createUserWithEmailAndPassword(
          email: 'dup@test.com',
          password: 'pass',
        ),
        throwsA(isA<FirebaseAuthException>()),
      );
    });
  });

  group('AuthService - signOut (non-Google user)', () {
    test('calls FirebaseAuth.signOut', () async {
      // User is not from Google (no providerData with google.com)
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.providerData).thenReturn([]);
      when(() => mockAuth.signOut()).thenAnswer((_) async {});

      await service.signOut();

      verify(() => mockAuth.signOut()).called(1);
    });

    test('completes successfully when not signed in', () async {
      when(() => mockAuth.currentUser).thenReturn(null);
      when(() => mockAuth.signOut()).thenAnswer((_) async {});

      await expectLater(service.signOut(), completes);
    });

    test('propagates exception from FirebaseAuth.signOut', () async {
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      when(() => mockUser.providerData).thenReturn([]);
      when(() => mockAuth.signOut()).thenThrow(Exception('sign out failed'));

      await expectLater(
        () async => service.signOut(),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('AuthService - constructor', () {
    test('uses injected FirebaseAuth instance', () {
      when(() => mockAuth.currentUser).thenReturn(mockUser);
      final testService = AuthService(firebaseAuth: mockAuth);
      expect(testService.currentUser, mockUser);
    });
  });
}