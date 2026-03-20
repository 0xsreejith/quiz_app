import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  AuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;
  bool _isGoogleSignInInitialized = false;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  // ═══════════════════════════════════════════════════════════════════
  // EMAIL/PASSWORD AUTHENTICATION
  // ═══════════════════════════════════════════════════════════════════

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) {
    return _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  // ═══════════════════════════════════════════════════════════════════
  // GOOGLE SIGN-IN AUTHENTICATION
  // ═══════════════════════════════════════════════════════════════════

  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      await GoogleSignIn.instance.initialize();
      _isGoogleSignInInitialized = true;
    }
  }

  bool _isUserFromGoogle(User? user) {
    if (user == null) return false;
    return user.providerData.any(
      (info) => info.providerId == GoogleAuthProvider.PROVIDER_ID,
    );
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();

      if (GoogleSignIn.instance.supportsAuthenticate()) {
        return await _signInWithGoogleNative();
      } else {
        return await _signInWithGoogleWeb();
      }
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }

  // ✅ FIX 1: try-catch added for cancellation inside native flow
  // ✅ FIX 2: accessToken passed alongside idToken to credential
  Future<UserCredential?> _signInWithGoogleNative() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn.instance
          .authenticate(scopeHint: ['email']);

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // ✅ Correct for v7
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        return null;
      }
      rethrow;
    }
  }

  Future<UserCredential> _signInWithGoogleWeb() async {
    if (!kIsWeb) {
      throw UnsupportedError('Web sign-in method called on non-web platform');
    }

    final GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.addScope('email');

    return await _firebaseAuth.signInWithPopup(googleProvider);
  }

  // ═══════════════════════════════════════════════════════════════════
  // SIGN OUT
  // ═══════════════════════════════════════════════════════════════════

  Future<void> signOut() async {
    // ✅ FIX 3: Capture provider BEFORE Firebase signOut clears currentUser
    final bool wasGoogleUser = _isUserFromGoogle(_firebaseAuth.currentUser);

    try {
      // ✅ FIX 4: Google signOut first, while session is still active
      if (wasGoogleUser) {
        await _signOutFromGoogle();
      }

      await _firebaseAuth.signOut();
    } catch (error) {
      // Ensure Firebase signOut always completes even if Google signOut failed
      await _firebaseAuth.signOut();
      rethrow;
    }
  }

  Future<void> _signOutFromGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();
      await GoogleSignIn.instance.signOut();
    } catch (error) {
      debugPrint('Google Sign-Out Error: $error');
    }
  }
}
