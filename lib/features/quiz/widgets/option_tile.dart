import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.hasAnswered,
    required this.onTap,
    super.key,
  });

  final String option;
  final bool isSelected;
  final bool isCorrect;
  final bool hasAnswered;
  final VoidCallback onTap;

  Color _getTileColor() {
    if (!hasAnswered) {
      return isSelected ? Colors.blue.shade50 : Colors.white;
    }
    if (isCorrect) return Colors.green.shade50;
    if (isSelected && !isCorrect) return Colors.red.shade50;
    return Colors.white;
  }

  Color _getBorderColor() {
    if (!hasAnswered) {
      return isSelected ? Colors.blue : Colors.grey.shade300;
    }
    if (isCorrect) return Colors.green;
    if (isSelected && !isCorrect) return Colors.red;
    return Colors.grey.shade300;
  }

  IconData? _getTrailingIcon() {
    if (!hasAnswered) return null;
    if (isCorrect) return Icons.check_circle;
    if (isSelected && !isCorrect) return Icons.cancel;
    return null;
  }

  Color? _getIconColor() {
    if (!hasAnswered) return null;
    if (isCorrect) return Colors.green;
    if (isSelected && !isCorrect) return Colors.red;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: hasAnswered ? null : onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: _getTileColor(),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _getBorderColor(), width: 1.5),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  option,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (_getTrailingIcon() != null)
                Icon(_getTrailingIcon(), color: _getIconColor(), size: 24),
            ],
          ),
        ),
      ),
    );
  }
}
