import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';
import 'package:quiz_app/features/settings/controllers/settings_controller.dart';
import 'package:quiz_app/features/settings/widgets/settings_action_row.dart';
import 'package:quiz_app/features/settings/widgets/settings_bottom_actions.dart';
import 'package:quiz_app/features/settings/widgets/settings_identity_section.dart';
import 'package:quiz_app/features/settings/widgets/settings_mode_option.dart';
import 'package:quiz_app/features/settings/widgets/settings_page_header.dart';
import 'package:quiz_app/features/settings/widgets/settings_section_card.dart';
import 'package:quiz_app/features/settings/widgets/settings_toggle_row.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());
    final authController = Get.find<AuthController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      appBar: const CommonAppBar(title: 'QuizApp'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SettingsPageHeader(),
                    const SizedBox(height: AppSpacing.xxxl),
                    SettingsIdentitySection(
                      displayName: authController.currentUserEmail.split('@').first,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    _buildInterfaceSection(controller),
                    const SizedBox(height: AppSpacing.lg),
                    _buildNotificationsSection(controller),
                    const SizedBox(height: AppSpacing.lg),
                    _buildSystemDataSection(),
                    const SizedBox(height: AppSpacing.xxxl),
                  ],
                ),
              ),
            ),
            SettingsBottomActions(
              onSave: () => Get.back(),
              onSignOut: authController.logout,
            ),
          ],
        ),
      ),
    );
  }

  /// Interface Preferences: Light/Dark mode options.
  Widget _buildInterfaceSection(SettingsController controller) {
    return SettingsSectionCard(
      icon: Icons.dark_mode_outlined,
      title: 'Interface Preferences',
      child: Obx(
        () => Column(
          children: [
            const SizedBox(height: AppSpacing.sm),
            SettingsModeOption(
              icon: Icons.light_mode_outlined,
              label: 'Light Mode',
              isSelected: !controller.isDarkMode.value,
              onTap: () => controller.isDarkMode.value = false,
            ),
            const SizedBox(height: AppSpacing.sm),
            SettingsModeOption(
              icon: Icons.dark_mode_outlined,
              label: 'Dark Mode',
              isSelected: controller.isDarkMode.value,
              onTap: () => controller.isDarkMode.value = true,
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  /// Push Notifications: toggle rows.
  Widget _buildNotificationsSection(SettingsController controller) {
    return SettingsSectionCard(
      icon: Icons.notifications_outlined,
      title: 'Push Notifications',
      child: Obx(
        () => Column(
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Divider(height: 1, color: AppColors.divider),
            ),
            SettingsToggleRow(
              title: 'Quiz Reminders',
              subtitle: 'Get notified when new daily challenges are live.',
              value: controller.quizReminders.value,
              onChanged: (v) => controller.quizReminders.value = v,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Divider(height: 1, color: AppColors.divider),
            ),
            SettingsToggleRow(
              title: 'Leaderboard Shifts',
              subtitle: 'Alerts when someone overtakes your rank.',
              value: controller.leaderboardShifts.value,
              onChanged: (v) => controller.leaderboardShifts.value = v,
            ),
          ],
        ),
      ),
    );
  }

  /// System & Data: reset and danger actions.
  Widget _buildSystemDataSection() {
    return SettingsSectionCard(
      icon: Icons.dns_outlined,
      title: 'System & Data',
      iconBgColor: AppColors.dangerBg,
      iconColor: AppColors.logoutRed,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Divider(height: 1, color: AppColors.divider),
          ),
          SettingsActionRow(
            title: 'Reset Onboarding',
            subtitle: 'Replay the introductory tutorial and tips.',
            trailingIcon: Icons.refresh_outlined,
            onTap: () {},
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Divider(height: 1, color: AppColors.divider),
          ),
          SettingsActionRow(
            title: 'Clear Quiz History',
            subtitle: 'Permanently deletes all past quiz results.',
            trailingIcon: Icons.delete_outline_rounded,
            titleColor: AppColors.logoutRed,
            trailingColor: AppColors.logoutRed,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
