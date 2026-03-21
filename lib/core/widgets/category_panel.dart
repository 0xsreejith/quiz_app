import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';
import 'package:quiz_app/core/utils/home_helpers.dart';

/// Floating category panel shown below the search bar.
/// Animated slide-down with 3 category rows + "VIEW ALL" footer.
class CategoryPanel extends StatelessWidget {
  const CategoryPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.categoryPanelBg,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...HomeHelpers.categories.map(_buildCategoryRow),
          const Divider(height: 1, color: AppColors.divider),
          _buildViewAllFooter(),
        ],
      ),
    );
  }

  Widget _buildCategoryRow(Map<String, dynamic> cat) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: AppColors.cardBg,
              borderRadius: BorderRadius.circular(AppSpacing.iconBoxRadius),
            ),
            child: Icon(
              cat['icon'] as IconData,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cat['title'] as String,
                  style: AppTextStyles.categoryTitle,
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      cat['subtitle'] as String,
                      style: AppTextStyles.categorySubtitle.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    if ((cat['meta'] as String).isNotEmpty) ...[
                      Text(
                        '  ·  ',
                        style: AppTextStyles.categorySubtitle.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                      Text(
                        cat['meta'] as String,
                        style: AppTextStyles.categorySubtitle.copyWith(
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: AppColors.textMuted,
            size: 22,
          ),
        ],
      ),
    );
  }

  Widget _buildViewAllFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(
          'VIEW ALL ${HomeHelpers.totalCategoryCount} CATEGORIES',
          style: AppTextStyles.tinyBold(color: AppColors.primary).copyWith(
            fontSize: 12,
            letterSpacing: 1.2,
          ),
        ),
      ),
    );
  }
}
