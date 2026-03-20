import 'package:get/get.dart';
import 'package:quiz_app/features/app_shell/controllers/app_shell_controller.dart';

class AppShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppShellController>(AppShellController.new);
  }
}
