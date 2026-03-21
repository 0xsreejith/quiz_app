import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// All-caps section header label used across multiple pages.
///
/// Example usage:
/// ```dart
/// SectionHeader(title: 'ACCOUNT ARCHITECTURE')
/// ```
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.padding,
    this.color,
  });

  final String title;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Widget label = Text(
      title,
      style: AppTextStyles.sectionLabel(color: color ?? AppColors.textMuted),
    );

    if (padding != null) {
      return Padding(padding: padding!, child: label);
    }
    return label;
  }
}
