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
import 'package:quiz_app/features/profile/controllers/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      init: ProfileController(),
      builder: (controller) {
        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: AppSpacing.profilePagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                ProfileAvatar(
                  email: Get.find<AuthController>().currentUserEmail,
                  tags: const <String>['MATHEMATICS', 'DATA SCIENCE', 'LOGIC'],
                ),
                AppSpacing.verticalXxl,
                const StatRow(
                  stats: <StatData>[
                    StatData(label: 'QUIZZES', value: '142'),
                    StatData(label: 'ACCURACY', value: '94.2', suffix: '%'),
                    StatData(label: 'STREAK', value: '12', suffix: 'd'),
                  ],
                ),
                AppSpacing.verticalXl,
                InfoCard(
                  header: 'BEST PERFORMANCE',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text(
                        'Advanced Algorithms',
                        style: AppTextStyles.cardTitle,
                      ),
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
                InfoCard(
                  header: 'DOMINANT FIELD',
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Theoretical Physics',
                            style: AppTextStyles.cardTitle,
                          ),
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
                _buildCategoryBadgesSection(controller),
                AppSpacing.verticalXxl,
                _buildAccountArchitectureSection(),
                AppSpacing.verticalXxl,
                _buildLogoutButton(Get.find<AuthController>()),
                AppSpacing.verticalLg,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryBadgesSection(ProfileController controller) {
    return Obx(() {
      if (controller.isLoadingBadges.value) {
        return const SizedBox.shrink();
      }

      final badgesWithBadge = controller.categoryScores
          .where((score) => score['badge'] != 'none')
          .toList();

      if (badgesWithBadge.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SectionHeader(
            title: 'CATEGORY BADGES',
            padding: EdgeInsets.only(left: 4, bottom: 14),
          ),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: badgesWithBadge.map((score) {
              return _BadgeChip(
                emoji: score['categoryEmoji'] as String? ?? '',
                categoryName: score['categoryName'] as String? ?? '',
                badge: score['badge'] as String? ?? 'none',
              );
            }).toList(),
          ),
        ],
      );
    });
  }

  Widget _buildAccountArchitectureSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const SectionHeader(
          title: 'ACCOUNT ARCHITECTURE',
          padding: EdgeInsets.only(left: 4, bottom: 14),
        ),
        Material(
          color: AppColors.cardBg,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadiusLarge),
          clipBehavior: Clip.antiAlias,
          child: const Column(
            children: <Widget>[
              SettingsTile(
                icon: Icons.shield_outlined,
                title: 'Identity & Privacy',
                subtitle: 'Manage personal visibility',
              ),
              Divider(height: 1, indent: 68, color: AppColors.divider),
              SettingsTile(
                icon: Icons.notifications_outlined,
                title: 'Notification Matrix',
                subtitle: 'Configure challenge alerts',
              ),
              Divider(height: 1, indent: 68, color: AppColors.divider),
              SettingsTile(
                icon: Icons.lock_outline_rounded,
                title: 'Security Protocols',
                subtitle: 'Encryption and access',
              ),
              Divider(height: 1, indent: 68, color: AppColors.divider),
              SettingsTile(
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

  Widget _buildLogoutButton(AuthController controller) {
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

class _BadgeChip extends StatelessWidget {
  const _BadgeChip({
    required this.emoji,
    required this.categoryName,
    required this.badge,
  });

  final String emoji;
  final String categoryName;
  final String badge;

  @override
  Widget build(BuildContext context) {
    final Color badgeColor;
    final String badgeEmoji;

    switch (badge) {
      case 'gold':
        badgeColor = const Color(0xFFD4AF37);
        badgeEmoji = '🥇';
        break;
      case 'silver':
        badgeColor = const Color(0xFF9CA3AF);
        badgeEmoji = '🥈';
        break;
      case 'bronze':
        badgeColor = const Color(0xFFB45309);
        badgeEmoji = '🥉';
        break;
      default:
        badgeColor = Colors.grey;
        badgeEmoji = '';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: badgeColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: badgeColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(
            categoryName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: badgeColor,
            ),
          ),
          const SizedBox(width: 4),
          Text(badgeEmoji, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
