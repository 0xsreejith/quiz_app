import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// A small rounded chip/tag used in the profile header.
class TagChip extends StatelessWidget {
  const TagChip({
    super.key,
    required this.label,
    this.borderColor,
    this.textColor,
  });

  final String label;
  final Color? borderColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor ?? AppColors.divider, width: 1.2),
      ),
      child: Text(
        label,
        style: textColor != null
            ? AppTextStyles.tagLabel.copyWith(color: textColor)
            : AppTextStyles.tagLabel,
      ),
    );
  }
}
