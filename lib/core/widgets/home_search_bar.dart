import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// Rounded search bar with search icon and filter/tune icon.
/// Accepts [onTap] to toggle category panel visibility.
class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSpacing.searchBarHeight,
        decoration: BoxDecoration(
          color: AppColors.searchBarBg,
          borderRadius: BorderRadius.circular(AppSpacing.searchBarRadius),
          border: Border.all(color: AppColors.searchBarBorder),
          boxShadow: const [
            BoxShadow(
              color: Color(0x08000000),
              blurRadius: 12,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Row(
          children: [
            Icon(Icons.search, color: AppColors.textMuted, size: 22),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'Search quizzes, categories...',
                style: AppTextStyles.searchPlaceholder,
              ),
            ),
            Icon(Icons.tune_rounded, color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}
