import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// Single leaderboard row: rank, avatar, name + subtitle, points.
class PerformerTile extends StatelessWidget {
  const PerformerTile({
    super.key,
    required this.rank,
    required this.name,
    required this.subtitle,
    required this.points,
    this.isCurrentUser = false,
  });

  final String rank;
  final String name;
  final String subtitle;
  final String points;
  final bool isCurrentUser;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: isCurrentUser ? AppColors.performerHighlight : Colors.transparent,
        borderRadius: BorderRadius.circular(AppSpacing.iconBoxRadius),
      ),
      child: Row(
        children: [
          // ── Rank ──
          SizedBox(
            width: 28,
            child: Text(
              rank,
              style: AppTextStyles.performerSubtitle(
                color: isCurrentUser ? AppColors.primary : AppColors.textMuted,
              ),
            ),
          ),

          // ── Avatar ──
          CircleAvatar(
            radius: 20,
            backgroundColor: AppColors.avatarBg,
            child: Text(
              name.isNotEmpty ? name[0] : '?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // ── Name + subtitle ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: isCurrentUser
                      ? AppTextStyles.performerName.copyWith(
                          color: AppColors.primary,
                        )
                      : AppTextStyles.performerName,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppTextStyles.performerSubtitle(
                    color: isCurrentUser
                        ? AppColors.primary.withValues(alpha: 0.7)
                        : AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // ── Points ──
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: points,
                  style: AppTextStyles.performerPoints,
                ),
                TextSpan(
                  text: ' pts',
                  style: AppTextStyles.performerSubtitle(
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
