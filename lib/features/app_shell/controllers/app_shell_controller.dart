import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/home/views/home_page.dart';
import 'package:quiz_app/features/live/views/live_page.dart';
import 'package:quiz_app/features/rank/views/rank_page.dart';
import 'package:quiz_app/features/history/views/history_page.dart';
import 'package:quiz_app/features/profile/views/profile_page.dart';

class AppShellController extends GetxController {
  final RxInt currentIndex = 0.obs;

  final List<Widget> pages = const <Widget>[
    HomePage(),
    LivePage(),
    RankPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  void changeTab(int index) {
    currentIndex.value = index;
  }
}
