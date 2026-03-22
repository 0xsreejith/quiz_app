import 'package:get/get.dart';
import 'package:quiz_app/features/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    // Use lazyPut so HomeController is only instantiated (and its
    // Get.find<AuthService> / Get.find<FirestoreService> calls executed)
    // after all core services have been registered by AppShellBinding.
    Get.lazyPut<HomeController>(HomeController.new);
  }
}