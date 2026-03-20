import 'package:get/get.dart';
import 'package:quiz_app/core/firebase/auth_service.dart';
import 'package:quiz_app/core/firebase/firestore_service.dart';
import 'package:quiz_app/features/auth/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
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
