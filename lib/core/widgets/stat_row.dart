import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// Data for a single stat item in a [StatRow].
class StatData {
  const StatData({required this.label, required this.value, this.suffix});

  final String label;
  final String value;
  final String? suffix;
}

/// Horizontal stats row with dividers between items.
///
/// Used in the profile page for QUIZZES / ACCURACY / STREAK.
class StatRow extends StatelessWidget {
  const StatRow({super.key, required this.stats});

  final List<StatData> stats;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadiusLarge),
      ),
      child: Row(
        children: _buildItems(),
      ),
    );
  }

  List<Widget> _buildItems() {
    final List<Widget> items = <Widget>[];
    for (int i = 0; i < stats.length; i++) {
      if (i > 0) {
        items.add(Container(width: 1, height: 48, color: AppColors.divider));
      }
      items.add(Expanded(child: _buildStatItem(stats[i])));
    }
    return items;
  }

  Widget _buildStatItem(StatData stat) {
    return Column(
      children: <Widget>[
        Text(stat.label, style: AppTextStyles.statLabel),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: AppTextStyles.statValue,
            children: <TextSpan>[
              TextSpan(text: stat.value),
              if (stat.suffix != null)
                TextSpan(text: stat.suffix, style: AppTextStyles.statSuffix),
            ],
          ),
        ),
      ],
    );
  }
}
