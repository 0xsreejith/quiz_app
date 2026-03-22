import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/features/app_shell/controllers/app_shell_controller.dart';
import 'package:quiz_app/core/widgets/bottom_nav_bar.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';
import 'package:quiz_app/routes/app_routes.dart';

class AppShellPage extends GetView<AppShellController> {
  const AppShellPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CommonAppBar(
          title: 'Quiz App',
          centerTitle: true,
          onAvatarTap: () => controller.changeTab(4),
          actions: controller.currentIndex.value == 4
              ? [
                  IconButton(
                    icon: const Icon(Icons.settings_outlined, color: AppColors.textMuted),
                    onPressed: () => Get.toNamed(AppRoutes.settings),
                  ),
                ]
              : null,
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
