import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/history/controllers/history_controller.dart';
import 'package:quiz_app/features/home/controllers/home_controller.dart';
import 'package:quiz_app/features/home/views/home_page.dart';
import 'package:quiz_app/features/history/views/history_page.dart';
import 'package:quiz_app/features/live/views/live_page.dart';
import 'package:quiz_app/features/profile/controllers/profile_controller.dart';
import 'package:quiz_app/features/profile/views/profile_page.dart';
import 'package:quiz_app/features/rank/controllers/leaderboard_controller.dart';
import 'package:quiz_app/features/rank/views/rank_page.dart';

class AppShellController extends GetxController {
  final RxInt currentIndex = 0.obs;
  bool _handledPostQuizRefresh = false;

  List<Widget> get pages => const <Widget>[
    HomePage(),
    LivePage(),
    RankPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  void onReady() {
    super.onReady();
    _refreshAfterQuizIfNeeded();
  }

  void changeTab(int index) {
    currentIndex.value = index;
  }

  Future<void> _refreshAfterQuizIfNeeded() async {
    if (_handledPostQuizRefresh) return;

    final Object? args = Get.arguments;
    if (args is! Map<String, dynamic> || args['refreshAfterQuiz'] != true) {
      return;
    }

    _handledPostQuizRefresh = true;
    await Future<void>.delayed(const Duration(milliseconds: 50));

    final List<Future<void>> jobs = <Future<void>>[];

    if (Get.isRegistered<HomeController>()) {
      jobs.add(
        Get.find<HomeController>().refreshAfterQuiz().catchError((_) {}),
      );
    }
    if (Get.isRegistered<HistoryController>()) {
      jobs.add(
        Get.find<HistoryController>().refreshHistory().catchError((_) {}),
      );
    }
    if (Get.isRegistered<ProfileController>()) {
      jobs.add(
        Get.find<ProfileController>().refreshAfterQuiz().catchError((_) {}),
      );
    }
    if (Get.isRegistered<LeaderboardController>()) {
      jobs.add(
        Get.find<LeaderboardController>()
            .fetchLeaderboard(forceServer: true)
            .catchError((_) {}),
      );
    }

    await Future.wait(jobs);
  }
}
