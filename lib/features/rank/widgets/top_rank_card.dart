import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

class TopRankCard extends StatelessWidget {
  const TopRankCard({
    super.key,
    required this.rank,
    required this.name,
    required this.score,
    required this.accuracy,
    required this.avgTime,
    required this.avatarWidget,
    this.badgeText,
  });

  final int rank;
  final String name;
  final String score;
  final String accuracy;
  final String avgTime;
  final Widget avatarWidget;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final bool isFirst = rank == 1;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: EdgeInsets.only(
        top: isFirst ? 24 : 20,
        bottom: isFirst ? 24 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: isFirst
            ? const Border(top: BorderSide(color: AppColors.primary, width: 4))
            : null,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          if (isFirst)
            Positioned(
              right: 16,
              top: -8,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.star, color: Colors.white, size: 16),
              ),
            ),
          if (!isFirst)
            Positioned(
              right: 20,
              top: 0,
              child: Text(
                rank.toString().padLeft(2, '0'),
                style: AppTextStyles.statLabel.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textMuted.withValues(alpha: 0.5),
                ),
              ),
            ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                avatarWidget,
                const SizedBox(height: 16),
                Text(name, style: AppTextStyles.cardTitle),
                const SizedBox(height: 4),
                Text(
                  '$score PTS',
                  style: isFirst
                      ? AppTextStyles.statValue.copyWith(fontSize: 15)
                      : AppTextStyles.subtitleMuted.copyWith(
                          fontSize: 13,
                          color: AppColors.textMuted,
                        ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    if (isFirst)
                      const Icon(
                        Icons.check_circle_outline,
                        size: 14,
                        color: AppColors.textMuted,
                      ),
                    if (isFirst) const SizedBox(width: 4),
                    Text(
                      '$accuracy ACCURACY',
                      style: AppTextStyles.statLabel.copyWith(
                        fontSize: isFirst ? 10 : 9,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(width: 16),
                    if (isFirst)
                      const Icon(
                        Icons.schedule,
                        size: 14,
                        color: AppColors.textMuted,
                      ),
                    if (isFirst) const SizedBox(width: 4),
                    Text(
                      '$avgTime AVG',
                      style: AppTextStyles.statLabel.copyWith(
                        fontSize: isFirst ? 10 : 9,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ],
                ),
                if (badgeText != null) ...<Widget>[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1.2,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
