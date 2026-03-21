import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';
import 'package:quiz_app/core/widgets/performer_tile.dart';

/// Card containing the "Top Performers" section title and a list of
/// [PerformerTile] widgets.
class TopPerformersCard extends StatelessWidget {
  const TopPerformersCard({
    super.key,
    required this.performers,
  });

  final List<Map<String, dynamic>> performers;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
            child: Text(
              'Top Performers',
              style: AppTextStyles.homeSectionTitle.copyWith(fontSize: 18),
            ),
          ),
          ...performers.asMap().entries.map((entry) {
            final performer = entry.value;
            final isLast = entry.key == performers.length - 1;
            return Column(
              children: [
                PerformerTile(
                  rank: performer['rank'] as String,
                  name: performer['name'] as String,
                  subtitle: performer['subtitle'] as String,
                  points: performer['points'] as String,
                  isCurrentUser: performer['isCurrentUser'] as bool,
                ),
                if (!isLast)
                  const Divider(
                    height: 1,
                    indent: 56,
                    endIndent: 16,
                    color: AppColors.divider,
                  ),
              ],
            );
          }),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
