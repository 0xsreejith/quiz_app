import 'package:get/get.dart';
import 'package:quiz_app/features/history/controllers/history_controller.dart';

class HistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HistoryController>(HistoryController.new, fenix: true);
  }
}
