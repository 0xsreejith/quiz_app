import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

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

  Color _getBgColor() {
    if (!hasAnswered) {
      return isSelected ? AppColors.primaryLight : AppColors.white;
    }
    if (isCorrect) return const Color(0xFFE8F5E9);
    if (isSelected && !isCorrect) return const Color(0xFFFFEBEE);
    return AppColors.white;
  }

  Color _getBorderColor() {
    if (!hasAnswered) {
      return isSelected ? AppColors.primary : Colors.grey.shade300;
    }
    if (isCorrect) return AppColors.accentGreen;
    if (isSelected && !isCorrect) return AppColors.logoutRed;
    return Colors.grey.shade300;
  }

  Color _getTextColor() {
    if (!hasAnswered) {
      return AppColors.textDark;
    }
    if (isCorrect) return AppColors.accentGreen;
    if (isSelected && !isCorrect) return AppColors.logoutRed;
    return AppColors.textDark;
  }

  IconData? _getTrailingIcon() {
    if (!hasAnswered) return null;
    if (isCorrect) return Icons.check_circle;
    if (isSelected && !isCorrect) return Icons.cancel;
    return null;
  }

  Color? _getIconColor() {
    if (!hasAnswered) return null;
    if (isCorrect) return AppColors.accentGreen;
    if (isSelected && !isCorrect) return AppColors.logoutRed;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: hasAnswered ? null : onTap,
          borderRadius: BorderRadius.circular(14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            decoration: BoxDecoration(
              color: _getBgColor(),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _getBorderColor(), width: 1.5),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    option,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: _getTextColor(),
                    ),
                  ),
                ),
                if (_getTrailingIcon() != null)
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _getIconColor()?.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      _getTrailingIcon(),
                      color: _getIconColor(),
                      size: 18,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
