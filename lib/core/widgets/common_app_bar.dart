import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.centerTitle = false,
    this.trailingLabel,
    this.onTrailingTap,
    this.isRedTrailing = false,
    this.onAvatarTap,
  });

  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  
  // Custom additions for the new design
  final String? trailingLabel;
  final VoidCallback? onTrailingTap;
  final bool isRedTrailing;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9FAFB),
      elevation: 0,
      centerTitle: centerTitle,
      leading: leading ?? Center(
        child: Icon(Icons.grid_view_rounded, color: Colors.grey.shade600, size: 28),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: AppColors.primary,
        ),
      ),
      actions: [
        if (trailingLabel != null)
          Center(
            child: GestureDetector(
              onTap: onTrailingTap,
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: isRedTrailing
                    ? BoxDecoration(
                        border: Border.all(color: Colors.red.shade200),
                        borderRadius: BorderRadius.circular(4),
                      )
                    : null,
                alignment: Alignment.center,
                child: Text(
                  trailingLabel!,
                  style: TextStyle(
                    fontSize: isRedTrailing ? 11 : 10,
                    fontWeight: FontWeight.w600,
                    color: isRedTrailing ? Colors.red.shade700 : Colors.grey.shade500,
                    letterSpacing: isRedTrailing ? 0.5 : 1.0,
                  ),
                ),
              ),
            ),
          ),
        if (actions != null) ...actions!
        else ...[
          if (trailingLabel != null) const SizedBox(width: AppSpacing.md),
          GestureDetector(
            onTap: onAvatarTap,
            child: Container(
              width: 32,
              height: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.avatarBg,
              ),
              child: const Icon(Icons.person, color: AppColors.avatarIcon, size: 20),
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
        ]
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1),
        child: Container(color: AppColors.divider, height: 1),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 1);
}