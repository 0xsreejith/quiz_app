import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

class RankListTile extends StatelessWidget {
  const RankListTile({
    super.key,
    required this.rank,
    required this.name,
    required this.accuracy,
    required this.score,
    required this.avatarWidget,
    this.badgeEmoji,
  });

  final String rank;
  final String name;
  final String accuracy;
  final String score;
  final Widget avatarWidget;
  final String? badgeEmoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      margin: const EdgeInsets.only(bottom: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 24,
            child: Text(
              rank,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textMuted,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(width: 12),
          avatarWidget,
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textDark,
                    ),
                  ),
                ),
                if (badgeEmoji != null && badgeEmoji!.isNotEmpty) ...<Widget>[
                  const SizedBox(width: 6),
                  Text(badgeEmoji!, style: const TextStyle(fontSize: 14)),
                ],
              ],
            ),
          ),
          Text(
            accuracy,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 60,
            child: Text(
              score,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
