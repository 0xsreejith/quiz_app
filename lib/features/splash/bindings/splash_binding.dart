import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/features/splash/controllers/splash_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthService>() && !Get.isPrepared<AuthService>()) {
      Get.lazyPut<AuthService>(AuthService.new, fenix: true);
    }

    // Splash navigation runs from controller.onReady(), so instantiate eagerly.
    Get.put<SplashController>(
      SplashController(authService: Get.find<AuthService>()),
    );
  }
}
