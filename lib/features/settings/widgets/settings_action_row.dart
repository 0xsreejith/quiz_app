import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// A danger/action row in a settings section with title, subtitle, and an icon button.
class SettingsActionRow extends StatelessWidget {
  const SettingsActionRow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.trailingIcon,
    this.titleColor,
    this.trailingColor,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData trailingIcon;
  final Color? titleColor;
  final Color? trailingColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: AppTextStyles.settingsTitle.fontSize,
                      fontWeight: AppTextStyles.settingsTitle.fontWeight,
                      color: titleColor ?? AppColors.textDarkest,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTextStyles.settingsSubtitle),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(trailingIcon, color: trailingColor ?? AppColors.textMuted, size: 22),
          ],
        ),
      ),
    );
  }
}

