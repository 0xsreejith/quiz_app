import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/firebase/auth_service.dart';
import 'package:quiz_app/core/firebase/firestore_service.dart';
import 'package:quiz_app/routes/app_routes.dart';

class AuthController extends GetxController {
  AuthController({
    required AuthService authService,
    required FirestoreService firestoreService,
  }) : _authService = authService,
       _firestoreService = firestoreService;

  final AuthService _authService;
  final FirestoreService _firestoreService;

  final RxBool isLoginLoading = false.obs;
  final RxBool isSignupLoading = false.obs;

  String get currentUserEmail => _authService.currentUser?.email ?? '';

  Future<void> login({required String email, required String password}) async {
    if (isLoginLoading.value) {
      return;
    }

    final String trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty || password.isEmpty) {
      _showError('Please enter both email and password.');
      return;
    }

    isLoginLoading.value = true;
    try {
      await _authService.signInWithEmailAndPassword(
        email: trimmedEmail,
        password: password,
      );
      Get.offAllNamed(AppRoutes.appShell);
    } on FirebaseAuthException catch (error) {
      _showError(_mapFirebaseAuthError(error));
    } catch (_) {
      _showError('Unable to sign in right now. Please try again.');
    } finally {
      isLoginLoading.value = false;
    }
  }

  Future<void> signup({required String email, required String password}) async {
    if (isSignupLoading.value) {
      return;
    }

    final String trimmedEmail = email.trim();
    if (trimmedEmail.isEmpty || password.isEmpty) {
      _showError('Please enter both email and password.');
      return;
    }

    isSignupLoading.value = true;
    try {
      final UserCredential credential = await _authService
          .createUserWithEmailAndPassword(
            email: trimmedEmail,
            password: password,
          );

      final User? createdUser = credential.user;
      if (createdUser != null) {
        await _firestoreService.createUserDocument(
          uid: createdUser.uid,
          email: createdUser.email ?? trimmedEmail,
        );
      }

      Get.offAllNamed(AppRoutes.appShell);
    } on FirebaseAuthException catch (error) {
      _showError(_mapFirebaseAuthError(error));
    } catch (_) {
      _showError('Unable to create account right now. Please try again.');
    } finally {
      isSignupLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(AppRoutes.login);
    } catch (_) {
      _showError('Unable to log out. Please try again.');
    }
  }

  String _mapFirebaseAuthError(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'user-not-found':
        return 'No account found for this email.';
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'email-already-in-use':
        return 'An account with this email already exists.';
      case 'too-many-requests':
        return 'Too many attempts. Please wait and try again.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return error.message ?? 'Authentication failed. Please try again.';
    }
  }

  void _showError(String message) {
    Get.snackbar(
      'Authentication Error',
      message,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 3),
    );
  }
}
