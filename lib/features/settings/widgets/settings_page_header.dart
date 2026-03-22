import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// Page header: "SYSTEM CONFIGURATION", "Settings" title, "SECURE ENVIRONMENT" badge.
class SettingsPageHeader extends StatelessWidget {
  const SettingsPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SYSTEM CONFIGURATION',
          style: AppTextStyles.configLabel(
            color: AppColors.primary.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        const Text('Settings', style: AppTextStyles.settingsPageTitle),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Icon(Icons.lock_outline, size: 13, color: AppColors.textMuted),
            const SizedBox(width: AppSpacing.xs),
            Text('SECURE ENVIRONMENT', style: AppTextStyles.secureLabel()),
          ],
        ),
      ],
    );
  }
}
