import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// A history quiz attempt card with icon, level badge, title, score, and status.
class AttemptCard extends StatelessWidget {
  const AttemptCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.level,
    required this.levelColor,
    required this.levelBgColor,
    required this.date,
    required this.title,
    required this.subtitle,
    required this.score,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
    required this.actionText,
    required this.actionColor,
    this.hasLeftBorder = false,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String level;
  final Color levelColor;
  final Color levelBgColor;
  final String date;
  final String title;
  final String subtitle;
  final String score;
  final String status;
  final Color statusColor;
  final IconData statusIcon;
  final String actionText;
  final Color actionColor;
  final bool hasLeftBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (hasLeftBorder)
              Container(width: 4, color: AppColors.darkNavy),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTopRow(),
                    const SizedBox(height: 24),
                    _buildBottomRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: iconBgColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: levelBgColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      level,
                      style: TextStyle(
                        fontSize: 9,
                        fontWeight: FontWeight.w800,
                        color: levelColor,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(title, style: AppTextStyles.attemptTitle),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SCORE',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: Colors.grey.shade400,
              ),
            ),
            const SizedBox(height: 4),
            Text(score, style: AppTextStyles.scoreValue),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 14),
                const SizedBox(width: 4),
                Text(
                  status,
                  style: AppTextStyles.tinyBold(color: statusColor),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              actionText,
              style: AppTextStyles.tinyBold(color: actionColor),
            ),
          ],
        ),
      ],
    );
  }
}
