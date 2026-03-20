import 'package:get/get.dart';
import 'package:quiz_app/features/live/controllers/live_controller.dart';

class LiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LiveController>(LiveController.new);
  }
}