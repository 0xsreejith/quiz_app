import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';
import 'package:quiz_app/features/settings/widgets/settings_section_card.dart';

/// Identity Profile section: shows the user's display name.
class SettingsIdentitySection extends StatelessWidget {
  const SettingsIdentitySection({
    super.key,
    required this.displayName,
  });

  final String displayName;

  @override
  Widget build(BuildContext context) {
    return SettingsSectionCard(
      icon: Icons.badge_outlined,
      title: 'Identity Profile',
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(height: 1, color: AppColors.divider),
            const SizedBox(height: AppSpacing.md),
            Text('DISPLAY NAME', style: AppTextStyles.secureLabel()),
            const SizedBox(height: AppSpacing.sm),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: AppColors.inputFieldBg,
                borderRadius: BorderRadius.circular(AppSpacing.sm),
                border: Border.all(color: AppColors.divider),
              ),
              child: Text(displayName, style: AppTextStyles.identityName),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This is how you will appear on global leaderboards.',
              style: AppTextStyles.helperText(),
            ),
          ],
        ),
      ),
    );
  }
}
