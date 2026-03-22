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

class ProfilePage extends GetView<ProfileController> {
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
            Obx(() {
              final List<String> topTags = controller.categoryScores
                  .take(3)
                  .map((Map<String, dynamic> c) =>
                      (c['categoryName'] as String? ?? '').toUpperCase())
                  .where((String s) => s.isNotEmpty)
                  .toList();

              return ProfileAvatar(
                email: Get.find<AuthController>().currentUserEmail,
                tags: topTags.isEmpty
                    ? const <String>['NO QUIZZES YET']
                    : topTags,
              );
            }),
            AppSpacing.verticalXxl,
            Obx(() => StatRow(
                  stats: <StatData>[
                    StatData(
                        label: 'QUIZZES',
                        value: '${controller.totalPlayed.value}'),
                    StatData(
                        label: 'ACCURACY',
                        value: '${controller.avgAccuracy.value}',
                        suffix: '%'),
                    const StatData(
                        label: 'STREAK', value: '—'),
                  ],
                )),
            AppSpacing.verticalXl,
            Obx(() {
              final Map<String, dynamic>? best = controller.bestCategory;
              return InfoCard(
                header: 'BEST PERFORMANCE',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      best?['categoryName'] as String? ?? '—',
                      style: AppTextStyles.cardTitle,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: '${best?['maxScore'] ?? '—'} ',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: AppColors.accentGreen,
                            ),
                          ),
                          const TextSpan(
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
              );
            }),
            AppSpacing.verticalLg,
            Obx(() {
              final Map<String, dynamic>? dominant =
                  controller.dominantCategory;
              return InfoCard(
                header: 'DOMINANT FIELD',
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          dominant?['categoryName'] as String? ?? '—',
                          style: AppTextStyles.cardTitle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${dominant?['totalAttempts'] ?? 0} Quizzes',
                          style: AppTextStyles.bodySmall(
                            color:
                                AppColors.textMuted.withValues(alpha: 0.8),
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
              );
            }),
            AppSpacing.verticalXxl,
            _buildCategoryBadgesSection(),
            AppSpacing.verticalXxl,
            _buildAccountArchitectureSection(),
            AppSpacing.verticalLg,
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBadgesSection() {
    return Obx(() {
      if (controller.isLoadingBadges.value) {
        return const SizedBox.shrink();
      }

      final List<Map<String, dynamic>> badgesWithBadge = controller
          .categoryScores
          .where((Map<String, dynamic> score) => score['badge'] != 'none')
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
            children: badgesWithBadge.map((Map<String, dynamic> score) {
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
