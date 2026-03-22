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

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _isGoingHome = false;
  late final int _score;
  late final int _totalQuestions;
  late final int _correctAnswers;
  late final RxInt _rxScore;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> args =
        Get.arguments as Map<String, dynamic>? ?? {};
    _score = args['score'] as int? ?? 0;
    _totalQuestions = args['totalQuestions'] as int? ?? 0;
    _correctAnswers = args['correctAnswers'] as int? ?? _score;
    _rxScore = _score.obs;
  }

  Future<void> _goHome() async {
    if (_isGoingHome) return;
    setState(() => _isGoingHome = true);

    final List<Future<void>> refreshJobs = <Future<void>>[];

    if (Get.isRegistered<HomeController>()) {
      refreshJobs.add(
        Get.find<HomeController>().refreshAfterQuiz().catchError((_) {}),
      );
    }
    if (Get.isRegistered<HistoryController>()) {
      refreshJobs.add(
        Get.find<HistoryController>().refreshHistory().catchError((_) {}),
      );
    }
    if (Get.isRegistered<ProfileController>()) {
      refreshJobs.add(
        Get.find<ProfileController>().refreshAfterQuiz().catchError((_) {}),
      );
    }
    if (Get.isRegistered<LeaderboardController>()) {
      refreshJobs.add(
        Get.find<LeaderboardController>().fetchLeaderboard().catchError((_) {}),
      );
    }

    await Future.wait(refreshJobs);

    if (mounted) {
      Get.offAllNamed(AppRoutes.appShell);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                        score: _rxScore,
                        correctAnswers: _correctAnswers,
                        totalQuestions: _totalQuestions,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      CorrectAnswersCard(
                        correctAnswers: _correctAnswers,
                        totalQuestions: _totalQuestions,
                      ),
                      const SizedBox(height: 48),
                      _buildHomeButton(),
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

  Widget _buildHomeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _isGoingHome ? null : _goHome,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.6),
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          elevation: 0,
        ),
        child: _isGoingHome
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Row(
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
    );
  }
}
