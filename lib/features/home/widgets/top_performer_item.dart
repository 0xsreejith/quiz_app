import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/features/home/data/models/home_models.dart';

class TopPerformerItem extends StatelessWidget {
  const TopPerformerItem({
    super.key,
    required this.performer,
    required this.onTap,
    required this.rank,
  });

  final TopPerformer performer;
  final VoidCallback onTap;
  final int rank;

  Color _rankColor() {
    switch (rank) {
      case 1:
        return const Color(0xFFD4AF37);
      case 2:
        return const Color(0xFF9CA3AF);
      case 3:
        return const Color(0xFFCD7F32);
      default:
        return AppColors.textMuted;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: performer.isCurrentUser
              ? AppColors.performerHighlight
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: <Widget>[
            // Rank number
            SizedBox(
              width: 28,
              child: Text(
                '#$rank',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: _rankColor(),
                ),
              ),
            ),
            const SizedBox(width: 12),

            // Avatar
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.avatarBg,
              backgroundImage: performer.avatarUrl.isNotEmpty
                  ? CachedNetworkImageProvider(performer.avatarUrl)
                  : null,
              child: performer.avatarUrl.isEmpty
                  ? Icon(Icons.person, color: AppColors.avatarIcon, size: 20)
                  : null,
            ),
            const SizedBox(width: 12),

            // Name + level
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    performer.displayName,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: performer.isCurrentUser
                          ? AppColors.primary
                          : AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Level ${performer.level} · ${performer.title}',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ),

            // Points
            Text(
              performer.formattedPoints,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textDarkest,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
