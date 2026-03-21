import 'package:flutter/material.dart';

/// Row with a section label on the left and an optional trailing widget
/// (e.g. page indicators, badge) on the right.
class SectionTitleRow extends StatelessWidget {
  const SectionTitleRow({
    super.key,
    required this.label,
    required this.title,
    this.labelStyle,
    this.titleStyle,
    this.trailing,
  });

  /// Small all-caps label above the title (e.g. "RECOMMENDED FOR YOU").
  final String label;

  /// Bold section title (e.g. "Featured Quizzes").
  final String title;

  final TextStyle? labelStyle;
  final TextStyle? titleStyle;

  /// Optional widget shown at trailing side of the title row.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              label,
              style: labelStyle ??
                  const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C8495),
                    letterSpacing: 1.8,
                  ),
            ),
          ),
        Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: titleStyle ??
                    const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      letterSpacing: -0.3,
                    ),
              ),
            ),
            ?trailing,
          ],
        ),
      ],
    );
  }
}
