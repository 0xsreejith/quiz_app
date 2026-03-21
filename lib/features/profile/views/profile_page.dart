import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';
import 'package:quiz_app/core/widgets/info_card.dart';
import 'package:quiz_app/core/widgets/profile_avatar.dart';
import 'package:quiz_app/core/widgets/section_header.dart';
import 'package:quiz_app/core/widgets/settings_tile.dart';
import 'package:quiz_app/core/widgets/stat_row.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';

class ProfilePage extends GetView<AuthController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: AppSpacing.profilePagePadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // ── Profile Header ─────────────────────────────
            ProfileAvatar(
              email: controller.currentUserEmail,
              tags: const <String>['MATHEMATICS', 'DATA SCIENCE', 'LOGIC'],
            ),
            AppSpacing.verticalXxl,

            // ── Stats Row ──────────────────────────────────
            const StatRow(
              stats: <StatData>[
                StatData(label: 'QUIZZES', value: '142'),
                StatData(label: 'ACCURACY', value: '94.2', suffix: '%'),
                StatData(label: 'STREAK', value: '12', suffix: 'd'),
              ],
            ),
            AppSpacing.verticalXl,

            // ── Best Performance ───────────────────────────
            InfoCard(
              header: 'BEST PERFORMANCE',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Advanced Algorithms',
                      style: AppTextStyles.cardTitle),
                  RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: '2,480 ',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accentGreen,
                          ),
                        ),
                        TextSpan(
                          text: 'pts',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: AppColors.accentGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            AppSpacing.verticalLg,

            // ── Dominant Field ─────────────────────────────
            InfoCard(
              header: 'DOMINANT FIELD',
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Text('Theoretical Physics',
                          style: AppTextStyles.cardTitle),
                      const SizedBox(height: 4),
                      Text(
                        '42 Quizzes • 96% Mastery',
                        style: AppTextStyles.bodySmall(
                          color: AppColors.textMuted.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.star_outline_rounded,
                    color: AppColors.starColor,
                    size: 28,
                  ),
                ],
              ),
            ),
            AppSpacing.verticalXxl,

            // ── Account Architecture ───────────────────────
            _buildAccountArchitectureSection(),
            AppSpacing.verticalXxl,

            // ── Logout Button ──────────────────────────────
            _buildLogoutButton(),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }

  Widget _buildAccountArchitectureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SectionHeader(
          title: 'ACCOUNT ARCHITECTURE',
          padding: EdgeInsets.only(left: 4, bottom: 14),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBg,
            borderRadius:
                BorderRadius.circular(AppSpacing.cardRadiusLarge),
          ),
          child: Column(
            children: <Widget>[
              const SettingsTile(
                icon: Icons.shield_outlined,
                title: 'Identity & Privacy',
                subtitle: 'Manage personal visibility',
              ),
              const Divider(height: 1, indent: 68, color: AppColors.divider),
              const SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notification Matrix',
                subtitle: 'Configure challenge alerts',
              ),
              const Divider(height: 1, indent: 68, color: AppColors.divider),
              const SettingsTile(
                icon: Icons.lock_outline_rounded,
                title: 'Security Protocols',
                subtitle: 'Encryption and access',
              ),
              const Divider(height: 1, indent: 68, color: AppColors.divider),
              const SettingsTile(
                icon: Icons.analytics_outlined,
                title: 'Performance Logs',
                subtitle: 'Export quiz history data',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: controller.logout,
        icon: const Icon(Icons.logout_rounded, size: 20),
        label: const Text(
          'Sign Out',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.logoutRed,
          side: const BorderSide(color: AppColors.logoutBorder),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.buttonRadius),
          ),
        ),
      ),
    );
  }
}