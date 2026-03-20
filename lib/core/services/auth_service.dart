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

  /// Ensures GoogleSignIn is properly initialized before use
  Future<void> _ensureGoogleSignInInitialized() async {
    if (!_isGoogleSignInInitialized) {
      try {
        await GoogleSignIn.instance.initialize();
        _isGoogleSignInInitialized = true;
      } catch (error) {
        rethrow;
      }
    }
  }

  /// Checks if the current user signed in using Google
  bool _isCurrentUserFromGoogle() {
    final User? user = _firebaseAuth.currentUser;
    if (user == null) return false;

    return user.providerData.any(
      (userInfo) => userInfo.providerId == GoogleAuthProvider.PROVIDER_ID,
    );
  }

  /// Signs in with Google using platform-appropriate method
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();

      if (GoogleSignIn.instance.supportsAuthenticate()) {
        return await _signInWithGoogleNative();
      } else {
        return await _signInWithGoogleWeb();
      }
    } on GoogleSignInException catch (e) {
      if (e.code.name == 'canceled') {
        return null;
      }
      rethrow;
    } catch (error) {
      rethrow;
    }
  }

  /// Native Google Sign-In flow (Android/iOS)
  Future<UserCredential> _signInWithGoogleNative() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate(
      scopeHint: ['email'],
    );

    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await _firebaseAuth.signInWithCredential(credential);
  }

  /// Web Google Sign-In flow using Firebase popup
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

  /// Signs out the current user from both Firebase and Google (if applicable)
  Future<void> signOut() async {
    // ✅ FIX: Check the Google provider BEFORE signing out from Firebase,
    // because signOut() clears currentUser, making the check always return false.
    final bool wasGoogleUser = _isCurrentUserFromGoogle();

    try {
      // Sign out from Google first (if applicable), while currentUser is still set
      if (wasGoogleUser) {
        await _signOutFromGoogle();
      }

      // Then sign out from Firebase
      await _firebaseAuth.signOut();
    } catch (error) {
      // Attempt Firebase sign-out even if Google sign-out failed,
      // so the user is always logged out of the app.
      await _firebaseAuth.signOut();
      rethrow;
    }
  }

  /// Safely signs out from Google Sign-In
  Future<void> _signOutFromGoogle() async {
    try {
      await _ensureGoogleSignInInitialized();
      await GoogleSignIn.instance.signOut();
    } catch (error) {
      debugPrint('Google Sign-Out Error: $error');
    }
  }
}