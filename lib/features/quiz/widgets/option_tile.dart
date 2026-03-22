import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

class OptionTile extends StatefulWidget {
  const OptionTile({
    required this.letter,
    required this.option,
    required this.isSelected,
    required this.isCorrect,
    required this.hasAnswered,
    required this.onTap,
    super.key,
  });

  final String letter;
  final String option;
  final bool isSelected;
  final bool isCorrect;
  final bool hasAnswered;
  final VoidCallback onTap;

  @override
  State<OptionTile> createState() => _OptionTileState();
}

class _OptionTileState extends State<OptionTile> {
  bool _isPressed = false;

  Color _getBgColor() {
    if (!widget.hasAnswered) {
      return widget.isSelected ? AppColors.primary : AppColors.white;
    }
    if (widget.isCorrect) return AppColors.accentGreen;
    if (widget.isSelected && !widget.isCorrect) return AppColors.logoutRed;
    return widget.isSelected ? AppColors.primary : AppColors.white;
  }

  Color _getBorderColor() {
    if (!widget.hasAnswered) {
      return widget.isSelected ? AppColors.primary : Colors.grey.shade200;
    }
    if (widget.isCorrect) return AppColors.accentGreen;
    if (widget.isSelected && !widget.isCorrect) return AppColors.logoutRed;
    return Colors.grey.shade200;
  }

  Color _getTextColor() {
    if (widget.isSelected || (widget.hasAnswered && widget.isCorrect)) {
      return AppColors.white;
    }
    return AppColors.textDark;
  }

  Color _getSubtitleColor() {
    if (widget.isSelected || (widget.hasAnswered && widget.isCorrect)) {
      return AppColors.white.withValues(alpha: 0.8);
    }
    return AppColors.textMuted;
  }

  IconData? _getTrailingIcon() {
    if (!widget.hasAnswered) {
      return widget.isSelected ? Icons.check_circle : null;
    }
    if (widget.isCorrect) return Icons.check_circle;
    if (widget.isSelected && !widget.isCorrect) return Icons.cancel;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final bool isFilled = widget.isSelected ||
        (widget.hasAnswered && widget.isCorrect) ||
        (widget.hasAnswered && widget.isSelected && !widget.isCorrect);
    final Color textColor = _getTextColor();

    return GestureDetector(
      onTapDown: widget.hasAnswered ? null : (_) => setState(() => _isPressed = true),
      onTapUp: widget.hasAnswered ? null : (_) => setState(() => _isPressed = false),
      onTapCancel: widget.hasAnswered ? null : () => setState(() => _isPressed = false),
      onTap: widget.hasAnswered ? null : widget.onTap,
      child: AnimatedScale(
        scale: _isPressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            color: _getBgColor(),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: _getBorderColor(), width: 1.5),
            boxShadow: [
              if (!widget.hasAnswered && !_isPressed)
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              if (_isPressed)
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  blurRadius: 0,
                  offset: const Offset(0, 0),
                ),
            ],
          ),
          child: Row(
            children: [
              // Letter Box
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isFilled ? Colors.transparent : AppColors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isFilled ? AppColors.white.withValues(alpha: 0.5) : Colors.grey.shade300,
                  ),
                ),
                child: Text(
                  widget.letter,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Option Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.option,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    if (widget.isSelected && !widget.hasAnswered) ...[
                      const SizedBox(height: 4),
                      Text(
                        'SELECTED ANSWER',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                          color: _getSubtitleColor(),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              
              // Trailing Icon
              if (_getTrailingIcon() != null)
                Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Icon(
                    _getTrailingIcon(),
                    color: AppColors.white,
                    size: 20,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
