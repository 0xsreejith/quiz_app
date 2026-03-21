import 'package:get/get.dart';
import 'package:quiz_app/core/services/firestore_service.dart';
import 'package:quiz_app/features/app_shell/controllers/app_shell_controller.dart';
import 'package:quiz_app/features/home/bindings/home_binding.dart';
import 'package:quiz_app/features/live/bindings/live_binding.dart';
import 'package:quiz_app/features/rank/bindings/rank_binding.dart';
import 'package:quiz_app/features/history/bindings/history_binding.dart';
import 'package:quiz_app/features/profile/bindings/profile_binding.dart';

class AppShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FirestoreService>(FirestoreService());
    Get.lazyPut<AppShellController>(AppShellController.new);

    HomeBinding().dependencies();
    LiveBinding().dependencies();
    RankBinding().dependencies();
    HistoryBinding().dependencies();
    ProfileBinding().dependencies();
  }
}
