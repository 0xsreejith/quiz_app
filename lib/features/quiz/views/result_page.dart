import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';
import 'package:quiz_app/features/quiz/controllers/quiz_controller.dart';
import 'package:quiz_app/features/quiz/widgets/correct_answers_card.dart';
import 'package:quiz_app/features/quiz/widgets/final_score_card.dart';

class ResultPage extends GetView<QuizController> {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: const CommonAppBar(
        title: 'QuizApp',
        trailingLabel: 'SESSION END',
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.xxxl,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'PERFORMANCE SUMMARY',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary.withValues(alpha: 0.8),
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    const Text(
                      'Quiz Completed!',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDarkest,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    Text(
                      'You\'ve finished the session. Below is your performance summary for this category.',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxxl),
                    
                    FinalScoreCard(
                      score: controller.score,
                      totalQuestions: controller.totalQuestions,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    
                    CorrectAnswersCard(
                      score: controller.score,
                      totalQuestions: controller.totalQuestions,
                    ),
                    const SizedBox(height: 48),
                    
                    _buildActionButtons(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: controller.goHome,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 0,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Back to Home',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.home_outlined, color: Colors.white, size: 20),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}
