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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10),
              const Text('Leaderboard', style: AppTextStyles.pageTitleLarge),
              const SizedBox(height: 24),
              // Top 3 Cards
              TopRankCard(
                rank: 1,
                name: 'Marcus Thorne',
                score: '14,210',
                accuracy: '98.5%',
                avgTime: '2M 14S',
                badgeText: 'ELITE MASTER',
                avatarWidget: _buildMockAvatar(
                  color: Colors.white,
                  bgColor: Colors.teal[700]!,
                  size: 64,
                  isSquare: true,
                ),
              ),
              TopRankCard(
                rank: 2,
                name: 'Elena Vance',
                score: '12,480',
                accuracy: '97.2%',
                avgTime: '2M 30S',
                avatarWidget: _buildMockAvatar(
                  color: Colors.white,
                  bgColor: Colors.teal[300]!,
                  size: 56,
                  isSquare: true,
                ),
              ),
              TopRankCard(
                rank: 3,
                name: 'Julian Chen',
                score: '11,940',
                accuracy: '96.8%',
                avgTime: '2M 45S',
                avatarWidget: _buildMockAvatar(
                  color: Colors.white,
                  bgColor: Colors.orange[300]!,
                  size: 56,
                  isSquare: true,
                ),
              ),
              const SizedBox(height: 32),
              // List header
              Row(
                children: <Widget>[
                  Text('RK', style: AppTextStyles.statLabel.copyWith(letterSpacing: 1.5)),
                  const SizedBox(width: 14),
                  Text('USER', style: AppTextStyles.statLabel.copyWith(letterSpacing: 1.5)),
                  const Spacer(),
                  Text('ACC %', style: AppTextStyles.statLabel.copyWith(letterSpacing: 1.5)),
                  const SizedBox(width: 16),
                  SizedBox(
                    width: 60,
                    child: Text('POINTS', textAlign: TextAlign.right, style: AppTextStyles.statLabel.copyWith(letterSpacing: 1.5)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Ranks 4-6
              RankListTile(
                rank: '04',
                name: 'Sarah Kovic',
                accuracy: '96.2',
                score: '10,850',
                avatarWidget: _buildInitialsAvatar('SK', AppColors.chipBgBlue, AppColors.darkNavy),
              ),
              RankListTile(
                rank: '05',
                name: 'David Ames',
                accuracy: '97.5',
                score: '10,420',
                avatarWidget: _buildInitialsAvatar('DA', AppColors.chipBgGreen, Colors.black),
              ),
              RankListTile(
                rank: '06',
                name: 'Lia Moreno',
                accuracy: '96.8',
                score: '9,980',
                avatarWidget: _buildMockAvatar(color: Colors.white, bgColor: Colors.brown[300]!, size: 36),
              ),
              const SizedBox(height: 24),
              Text('YOUR POSITION', style: AppTextStyles.statLabel.copyWith(letterSpacing: 1.5, color: AppColors.primary)),
              const SizedBox(height: 8),
              YourPositionCard(
                rank: '142nd',
                name: 'Elite Architect',
                subtitle: 'TOP 12% OVERALL',
                score: '4,120 PTS',
                trend: '+240 this week',
                avatarWidget: _buildMockAvatar(color: Colors.black, bgColor: Colors.orange[200]!, size: 40),
              ),
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
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: 0.5),
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
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13, letterSpacing: 0.5),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMockAvatar({required Color color, required Color bgColor, required double size, bool isSquare = false}) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(isSquare ? 16 : size / 2),
        border: isSquare ? Border.all(color: Colors.blue.withOpacity(0.2), width: 3) : null,
      ),
      child: Center(
        child: Icon(Icons.person, color: color, size: size * 0.6),
      ),
    );
  }

  Widget _buildInitialsAvatar(String initials, Color bgColor, Color textColor) {
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
