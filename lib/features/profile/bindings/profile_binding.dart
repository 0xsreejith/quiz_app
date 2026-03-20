import 'package:get/get.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    // AuthController and its dependencies are already registered by AuthBinding
    // We just ensure they're available if not already registered
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(
        () => AuthController(
          authService: Get.find(),
          firestoreService: Get.find(),
        ),
        fenix: true,
      );
    }
  }
}