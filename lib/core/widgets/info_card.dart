import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// A bordered card with a small all-caps header label and custom content.
///
/// Used for "Best Performance" and "Dominant Field" cards on the profile page.
class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.header,
    required this.child,
  });

  final String header;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            header,
            style: AppTextStyles.miniLabel(),
          ),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
