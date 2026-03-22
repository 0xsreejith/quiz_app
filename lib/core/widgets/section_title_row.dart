import 'package:flutter/material.dart';

class SectionTitleRow extends StatelessWidget {
  const SectionTitleRow({
    super.key,
    required this.label,
    required this.title,
    this.labelStyle,
    this.titleStyle,
    this.trailing,
  });

  final String label;
  final String title;
  final TextStyle? labelStyle;
  final TextStyle? titleStyle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (label.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              label,
              style:
                  labelStyle ??
                  const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF7C8495),
                    letterSpacing: 1.8,
                  ),
            ),
          ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                title,
                style:
                    titleStyle ??
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
