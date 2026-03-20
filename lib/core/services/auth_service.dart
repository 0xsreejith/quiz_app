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
        // If initialization fails, we'll handle it in the calling method
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

      // Check if platform supports authenticate method
      if (GoogleSignIn.instance.supportsAuthenticate()) {
        return await _signInWithGoogleNative();
      } else {
        // Fallback for web or unsupported platforms
        return await _signInWithGoogleWeb();
      }
    } on GoogleSignInException catch (e) {
      // Handle Google Sign-In specific exceptions
      if (e.code.name == 'canceled') {
        // User cancelled the sign-in process
        return null;
      }
      rethrow;
    } catch (error) {
      // Rethrow for controller to handle
      rethrow;
    }
  }

  /// Native Google Sign-In flow (Android/iOS)
  Future<UserCredential> _signInWithGoogleNative() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn.instance.authenticate(
      scopeHint: ['email'],
    );

    // Get authentication tokens (synchronous in v7)
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    // Create Firebase credential
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the Google credential
    return await _firebaseAuth.signInWithCredential(credential);
  }

  /// Web Google Sign-In flow using Firebase popup
  Future<UserCredential> _signInWithGoogleWeb() async {
    if (!kIsWeb) {
      throw UnsupportedError('Web sign-in method called on non-web platform');
    }

    // Create Google auth provider for web
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.addScope('email');

    // Use Firebase's built-in popup for web
    return await _firebaseAuth.signInWithPopup(googleProvider);
  }

  // ═══════════════════════════════════════════════════════════════════
  // SIGN OUT
  // ═══════════════════════════════════════════════════════════════════

  /// Signs out the current user from both Firebase and Google (if applicable)
  Future<void> signOut() async {
    try {
      // Always sign out from Firebase first
      await _firebaseAuth.signOut();

      // Only sign out from Google if:
      // 1. User was signed in with Google
      // 2. GoogleSignIn can be safely initialized
      if (_isCurrentUserFromGoogle()) {
        await _signOutFromGoogle();
      }
    } catch (error) {
      // If Google sign-out fails, we've already signed out from Firebase
      // This ensures the user is still logged out from the app
      rethrow;
    }
  }

  /// Safely signs out from Google Sign-In
  Future<void> _signOutFromGoogle() async {
    try {
      // Ensure GoogleSignIn is initialized before using it
      await _ensureGoogleSignInInitialized();
      
      // Sign out from Google
      await GoogleSignIn.instance.signOut();
    } catch (error) {
      // Log error but don't throw - Firebase sign-out already succeeded
      // In production, you might want to log this to your error tracking service
      debugPrint('Google Sign-Out Error: $error');
    }
  }
}
