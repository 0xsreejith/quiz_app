import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// A selectable option tile for Light/Dark mode in Interface Preferences.
class SettingsModeOption extends StatelessWidget {
  const SettingsModeOption({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : AppColors.inputFieldBg,
            borderRadius: BorderRadius.circular(AppSpacing.sm),
            border: Border.all(
              color: isSelected ? AppColors.primary : AppColors.divider,
              width: isSelected ? 1.5 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isSelected ? AppColors.primary : AppColors.textMuted,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  label,
                  style: AppTextStyles.modeOptionLabel(isSelected: isSelected),
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}
