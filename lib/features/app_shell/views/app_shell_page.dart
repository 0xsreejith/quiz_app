import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/app_shell/controllers/app_shell_controller.dart';
import 'package:quiz_app/core/widgets/bottom_nav_bar.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';

class AppShellPage extends GetView<AppShellController> {
  const AppShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: const CommonAppBar(
          title: 'Quiz App',
          centerTitle: true,
        ),
        body: IndexedStack(
          index: controller.currentIndex.value,
          children: controller.pages,
        ),
        bottomNavigationBar: BottomNavBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeTab,
        ),
      ),
    );
  }
}
