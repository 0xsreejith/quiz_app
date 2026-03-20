import 'package:get/get.dart';
import 'package:quiz_app/core/firebase/auth_service.dart';
import 'package:quiz_app/features/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    // Splash navigation runs from controller.onReady(), so instantiate eagerly.
    Get.put<SplashController>(
      SplashController(authService: Get.find<AuthService>()),
    );
  }
}
