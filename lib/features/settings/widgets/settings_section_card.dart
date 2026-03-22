import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// A card container used to group related settings rows.
///
/// Matches the reference design: icon badge, bold title, child content,
/// and a subtle white background with shadow.
class SettingsSectionCard extends StatelessWidget {
  const SettingsSectionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.child,
    this.iconBgColor,
    this.iconColor,
  });

  final IconData icon;
  final String title;
  final Widget child;
  final Color? iconBgColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBgColor ?? AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppSpacing.iconBoxRadius),
                  ),
                  child: Icon(icon, color: iconColor ?? AppColors.primary, size: 20),
                ),
                const SizedBox(width: AppSpacing.md),
                Text(title, style: AppTextStyles.cardTitle),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}
