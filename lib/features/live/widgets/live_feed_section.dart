import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

class LiveFeedSection extends StatelessWidget {
  const LiveFeedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'LOBBY FEED',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textMuted,
                  letterSpacing: 2.0,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: const BoxDecoration(
                      color: AppColors.emerald,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Text(
                    'REAL-TIME',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: AppColors.emerald,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.divider),
          const SizedBox(height: 24),
          _buildFeedItem('14:02', 'System', 'Waiting for host to initiate sequence.', isSystem: true),
          const SizedBox(height: 16),
          _buildFeedItem('14:03', 'Alex', 'This is going to be tough!', color: AppColors.primary),
          const SizedBox(height: 16),
          _buildFeedItem('14:04', 'Julian', 'joined the lobby.', isAction: true),
        ],
      ),
    );
  }

  Widget _buildFeedItem(String time, String author, String message, {bool isSystem = false, bool isAction = false, Color? color}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          time,
          style: TextStyle(
            fontSize: 10,
            color: AppColors.textMuted.withValues(alpha: 0.5),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textDark,
                fontFamily: 'Inter',
                height: 1.4,
              ),
              children: [
                TextSpan(
                  text: '$author${isAction ? ' ' : ': '}',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: isSystem ? AppColors.textDarkest : (color ?? AppColors.textDarkest),
                  ),
                ),
                TextSpan(
                  text: message,
                  style: TextStyle(
                    color: isAction ? AppColors.textMuted : AppColors.textDark,
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
