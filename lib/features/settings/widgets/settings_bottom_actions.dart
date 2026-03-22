import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// Bottom action bar: Save button, Sign Out link, and version footer.
class SettingsBottomActions extends StatelessWidget {
  const SettingsBottomActions({
    super.key,
    required this.onSave,
    required this.onSignOut,
  });

  final VoidCallback onSave;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.scaffoldBg,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.xxl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                ),
                elevation: 0,
              ),
              child: const Text('SAVE ALL CHANGES', style: AppTextStyles.saveButton),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: onSignOut,
            child: const Text('SIGN OUT', style: AppTextStyles.signOutLink),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'VERSION 2.4.6 (BUILD 901)\n© QUIZAPP ARCHITECTURE',
            textAlign: TextAlign.center,
            style: AppTextStyles.versionText(),
          ),
        ],
      ),
    );
  }
}
