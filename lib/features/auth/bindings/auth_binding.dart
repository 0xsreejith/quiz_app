import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // fenix: true keeps these alive across Get.offAllNamed() calls so that
    // SplashBinding and any other early consumers can always Get.find<> them.
    Get.lazyPut<AuthService>(AuthService.new, fenix: true);
    Get.lazyPut<FirestoreService>(FirestoreService.new, fenix: true);
    Get.lazyPut<AuthController>(
      () => AuthController(
        authService: Get.find<AuthService>(),
        firestoreService: Get.find<FirestoreService>(),
      ),
      fenix: true,
    );
  }
}