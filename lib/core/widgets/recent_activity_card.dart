import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// Single recent activity row: icon, title + meta, accuracy percentage.
class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({
    super.key,
    required this.title,
    required this.meta,
    required this.accuracy,
  });

  final String title;
  final String meta;
  final String accuracy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Icon ──
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.iconBoxRadius),
            ),
            child: const Icon(
              Icons.quiz_outlined,
              color: AppColors.primary,
              size: 22,
            ),
          ),
          const SizedBox(width: 14),

          // ── Title + meta ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.activityTitle),
                const SizedBox(height: 4),
                Text(meta, style: AppTextStyles.activityMeta),
              ],
            ),
          ),

          // ── Accuracy ──
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(accuracy, style: AppTextStyles.activityAccuracy),
              const SizedBox(height: 2),
              Text(
                'ACCURACY',
                style: AppTextStyles.tinyBold(color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
