import 'package:get/get.dart';
import 'package:quiz_app/features/rank/controllers/leaderboard_controller.dart';

class RankBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeaderboardController>(LeaderboardController.new);
  }
}