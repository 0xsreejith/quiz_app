import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';
import 'package:quiz_app/core/utils/display_helpers.dart';
import 'package:quiz_app/core/widgets/tag_chip.dart';

/// Profile header block: avatar + gradient badge + name + email + tags.
class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    super.key,
    required this.email,
    required this.tags,
    required this.badgeLabel,
  });

  final String email;
  final List<String> tags;
  final String badgeLabel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _buildAvatarWithBadge(),
        const SizedBox(height: 20),
        Text(
          DisplayHelpers.formatDisplayName(email),
          style: AppTextStyles.displayName,
        ),
        const SizedBox(height: 6),
        Text(
          DisplayHelpers.formatEmailDisplay(email),
          style: AppTextStyles.subtitleMuted,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: tags.map((String tag) => TagChip(label: tag)).toList(),
        ),
      ],
    );
  }

  Widget _buildAvatarWithBadge() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.avatarBg,
            borderRadius: BorderRadius.circular(AppSpacing.avatarRadius),
            border: Border.all(color: AppColors.primaryLight, width: 3),
          ),
          child: const Icon(
            Icons.person,
            size: 48,
            color: AppColors.avatarIcon,
          ),
        ),
        Positioned(
          bottom: -10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: <Color>[AppColors.primary, AppColors.primaryAccent],
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(Icons.verified, color: Colors.white, size: 14),
                SizedBox(width: 4),
                Text(
                  badgeLabel.toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
