import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';
import 'package:quiz_app/features/history/controllers/history_controller.dart';
import 'package:quiz_app/features/home/controllers/home_controller.dart';
import 'package:quiz_app/features/profile/controllers/profile_controller.dart';
import 'package:quiz_app/features/quiz/widgets/correct_answers_card.dart';
import 'package:quiz_app/features/quiz/widgets/final_score_card.dart';
import 'package:quiz_app/features/rank/controllers/leaderboard_controller.dart';
import 'package:quiz_app/routes/app_routes.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args =
        Get.arguments as Map<String, dynamic>? ?? {};
    final int earnedPointsValue = args['score'] as int? ?? 0;
    final int correctAnswers = args['correctAnswers'] as int? ?? 0;
    final int totalQuestions = args['totalQuestions'] as int? ?? 0;
    final RxInt earnedPoints = earnedPointsValue.obs;

    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, void result) async {
        if (didPop) return;
        await _goHome();
      },
      child: Scaffold(
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
                        score: earnedPoints,
                        correctAnswers: correctAnswers,
                        totalQuestions: totalQuestions,
                      ),
                      const SizedBox(height: AppSpacing.lg),

                      CorrectAnswersCard(
                        correctAnswers: correctAnswers,
                        totalQuestions: totalQuestions,
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
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: _goHome,
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

  Future<void> _goHome() async {
    // Replace the route stack first; the previous shell controllers were
    // disposed, so refreshing before navigation updated nothing visible.
    await Get.offAllNamed(AppRoutes.appShell);
    await Future<void>.delayed(const Duration(milliseconds: 100));
    await _refreshShellDataAfterQuiz();
  }

  /// Pulls authoritative totals from the server so home, rank, profile, and
  /// history match the quiz that just finished.
  Future<void> _refreshShellDataAfterQuiz() async {
    await Future.wait<void>(<Future<void>>[
      _runRefresh(() async {
        if (Get.isRegistered<HomeController>()) {
          await Get.find<HomeController>().refreshAfterQuiz();
        }
      }),
      _runRefresh(() async {
        if (Get.isRegistered<ProfileController>()) {
          await Get.find<ProfileController>().loadProfileData(fromServer: true);
        }
      }),
      _runRefresh(() async {
        if (Get.isRegistered<LeaderboardController>()) {
          await Get.find<LeaderboardController>().fetchLeaderboard(
            fromServer: true,
          );
        }
      }),
      _runRefresh(() async {
        if (Get.isRegistered<HistoryController>()) {
          await Get.find<HistoryController>().loadHistory(fromServer: true);
        }
      }),
    ]);
  }

  Future<void> _runRefresh(Future<void> Function() fn) async {
    try {
      await fn();
    } catch (_) {}
  }
}
