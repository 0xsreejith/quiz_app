import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';
import 'package:quiz_app/features/rank/controllers/leaderboard_controller.dart';
import 'package:quiz_app/features/rank/widgets/rank_list_tile.dart';
import 'package:quiz_app/features/rank/widgets/top_rank_card.dart';
import 'package:quiz_app/features/rank/widgets/your_position_card.dart';

class LeaderboardPage extends GetView<LeaderboardController> {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(color: AppColors.primary),
            ),
          );
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline,
                      color: AppColors.textMuted, size: 48),
                  const SizedBox(height: 16),
                  const Text('Unable to load data',
                      style: AppTextStyles.cardTitle),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: controller.fetchLeaderboard,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (controller.scores.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.inbox_outlined,
                      color: AppColors.textMuted, size: 48),
                  SizedBox(height: 16),
                  Text('No data yet', style: AppTextStyles.cardTitle),
                  SizedBox(height: 8),
                  Text(
                    'Complete a quiz to see your results here',
                    style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        }

        final List<Map<String, dynamic>> topThree =
            controller.scores.take(3).toList();
        final List<Map<String, dynamic>> rest =
            controller.scores.skip(3).take(10).toList();

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 10),
                const Text('Leaderboard', style: AppTextStyles.pageTitleLarge),
                const SizedBox(height: 24),
                // Top 3 Cards
                ...topThree.asMap().entries.map((MapEntry<int, Map<String, dynamic>> entry) {
                  final int i = entry.key;
                  final Map<String, dynamic> s = entry.value;
                  final String email = s['email'] as String? ?? 'User';
                  final String name = email.split('@').first;
                  final int scoreVal = s['score'] as int? ?? 0;
                  final List<Color> bgColors = <Color>[
                    Colors.teal[700]!,
                    Colors.teal[300]!,
                    Colors.orange[300]!,
                  ];
                  return TopRankCard(
                    rank: i + 1,
                    name: name,
                    score: _formatScore(scoreVal),
                    accuracy: '—',
                    avgTime: '—',
                    avatarWidget: _buildInitialsAvatar(
                      name.isNotEmpty ? name[0].toUpperCase() : 'U',
                      bgColors[i],
                      Colors.white,
                    ),
                    badgeText: i == 0 ? 'TOP SCORER' : null,
                  );
                }),
                const SizedBox(height: 32),
                // List header
                if (rest.isNotEmpty) ...[
                  Row(
                    children: <Widget>[
                      Text('RK',
                          style: AppTextStyles.statLabel
                              .copyWith(letterSpacing: 1.5)),
                      const SizedBox(width: 14),
                      Text('USER',
                          style: AppTextStyles.statLabel
                              .copyWith(letterSpacing: 1.5)),
                      const Spacer(),
                      Text('ACC %',
                          style: AppTextStyles.statLabel
                              .copyWith(letterSpacing: 1.5)),
                      const SizedBox(width: 16),
                      SizedBox(
                        width: 60,
                        child: Text('POINTS',
                            textAlign: TextAlign.right,
                            style: AppTextStyles.statLabel
                                .copyWith(letterSpacing: 1.5)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Ranks 4+
                  ...rest.asMap().entries.map((MapEntry<int, Map<String, dynamic>> entry) {
                    final int i = entry.key;
                    final Map<String, dynamic> s = entry.value;
                    final String email = s['email'] as String? ?? 'User';
                    final String name = email.split('@').first;
                    final int scoreVal = s['score'] as int? ?? 0;
                    final String rankStr =
                        (i + 4).toString().padLeft(2, '0');
                    return RankListTile(
                      rank: rankStr,
                      name: name,
                      accuracy: '—',
                      score: _formatScore(scoreVal),
                      avatarWidget: _buildInitialsAvatar(
                        name.isNotEmpty ? name[0].toUpperCase() : 'U',
                        AppColors.chipBgBlue,
                        AppColors.darkNavy,
                      ),
                    );
                  }),
                ],
                const SizedBox(height: 24),
                // Your position
                _buildYourPosition(),
                const SizedBox(height: 32),
                // Buttons
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'ENTER GLOBAL TOURNAMENT',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: AppColors.textDarkest,
                      side: const BorderSide(color: Colors.white, width: 0),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'VIEW ALL TIME RANKINGS',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          letterSpacing: 0.5),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildYourPosition() {
    final Map<String, dynamic>? userScore = controller.currentUserScore;
    final int rank = controller.currentUserRank;

    if (userScore == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('YOUR POSITION',
              style: AppTextStyles.statLabel
                  .copyWith(letterSpacing: 1.5, color: AppColors.primary)),
          const SizedBox(height: 8),
          YourPositionCard(
            rank: '—',
            name: 'Play a quiz to rank',
            subtitle: 'NOT RANKED YET',
            score: '0 PTS',
            trend: '',
            avatarWidget: _buildInitialsAvatar('?', AppColors.chipBgBlue, AppColors.darkNavy),
          ),
        ],
      );
    }

    final String email = userScore['email'] as String? ?? '';
    final String name = email.split('@').first;
    final int scoreVal = userScore['score'] as int? ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('YOUR POSITION',
            style: AppTextStyles.statLabel
                .copyWith(letterSpacing: 1.5, color: AppColors.primary)),
        const SizedBox(height: 8),
        YourPositionCard(
          rank: _ordinal(rank),
          name: name.isNotEmpty ? name : 'You',
          subtitle: 'TOP ${_percentile(rank, controller.scores.length)}% OVERALL',
          score: '$scoreVal PTS',
          trend: '',
          avatarWidget: _buildInitialsAvatar(
            name.isNotEmpty ? name[0].toUpperCase() : 'U',
            AppColors.chipBgBlue,
            AppColors.darkNavy,
          ),
        ),
      ],
    );
  }

  String _ordinal(int n) {
    if (n <= 0) return '—';
    final int mod100 = n % 100;
    final String suffix = (mod100 >= 11 && mod100 <= 13)
        ? 'th'
        : <String>['th', 'st', 'nd', 'rd', 'th'][n % 10 < 4 ? n % 10 : 4];
    return '$n$suffix';
  }

  String _percentile(int rank, int total) {
    if (total == 0) return '0';
    return ((rank / total) * 100).round().toString();
  }

  String _formatScore(int score) {
    if (score >= 1000) {
      return '${(score / 1000).toStringAsFixed(1)}k';
    }
    return score.toString();
  }

  Widget _buildInitialsAvatar(
      String initials, Color bgColor, Color textColor) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
