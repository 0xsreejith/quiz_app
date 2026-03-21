import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

/// Dark gradient featured quiz card with category chip, player count,
/// title, description, and a "Start Quiz →" CTA.
class FeaturedQuizCard extends StatelessWidget {
  const FeaturedQuizCard({
    super.key,
    required this.title,
    required this.description,
    required this.category,
    required this.players,
    required this.onStartQuiz,
  });

  final String title;
  final String description;
  final String category;
  final String players;
  final VoidCallback onStartQuiz;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSpacing.featuredCardRadius),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.featuredGradientStart,
            AppColors.featuredGradientEnd,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x30000040),
            blurRadius: 24,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Category chip + player count ──
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    category,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Colors.white70,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const Spacer(),
                Icon(Icons.people_alt_outlined,
                    color: Colors.white54, size: 16),
                const SizedBox(width: 5),
                Text(
                  players,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white54,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Spacer(flex: 2),

            // ── Title ──
            Text(title, style: AppTextStyles.featuredTitle),
            const SizedBox(height: 10),

            // ── Description ──
            Text(description, style: AppTextStyles.featuredDescription),
            const Spacer(flex: 3),

            // ── CTA Button ──
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onStartQuiz,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white,
                  foregroundColor: AppColors.textDarkest,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Start Quiz', style: AppTextStyles.ctaButton),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
