import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/app_shell/controllers/app_shell_controller.dart';
import 'package:quiz_app/features/app_shell/views/pages/history_page.dart';
import 'package:quiz_app/features/app_shell/views/pages/home_page.dart';
import 'package:quiz_app/features/app_shell/views/pages/live_page.dart';
import 'package:quiz_app/features/app_shell/views/pages/profile_page.dart';
import 'package:quiz_app/features/app_shell/views/pages/rank_page.dart';

class AppShellPage extends GetView<AppShellController> {
  const AppShellPage({super.key});

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    LivePage(),
    RankPage(),
    HistoryPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: _pages[controller.currentIndex.value],
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv_outlined),
              label: 'Live',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events_outlined),
              label: 'Rank',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.history_outlined),
              label: 'History',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
