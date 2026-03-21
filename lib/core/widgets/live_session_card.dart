import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// Card showing a live session with avatar, title, meta info, and Join button.
class LiveSessionCard extends StatelessWidget {
  const LiveSessionCard({
    super.key,
    required this.title,
    required this.startsIn,
    required this.waiting,
  });

  final String title;
  final String startsIn;
  final String waiting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.cardPadding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          // ── Avatar / icon ──
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppSpacing.iconBoxRadius),
            ),
            child: const Icon(
              Icons.wifi_tethering,
              color: AppColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: 14),

          // ── Title + meta ──
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.activityTitle,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      startsIn,
                      style: AppTextStyles.tinyBold(color: AppColors.textMuted),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      waiting,
                      style: AppTextStyles.tinyBold(color: AppColors.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Join button ──
          SizedBox(
            height: 40,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.joinButton,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 22),
              ),
              child: const Text(
                'Join',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
