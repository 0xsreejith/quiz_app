import 'package:get/get.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';
import 'package:quiz_app/features/profile/controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    if (!Get.isRegistered<AuthController>()) {
      Get.lazyPut<AuthController>(
        () => AuthController(
          authService: Get.find(),
          firestoreService: Get.find(),
        ),
        fenix: true,
      );
    }
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
