import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';
import 'package:quiz_app/features/quiz/widgets/correct_answers_card.dart';
import 'package:quiz_app/features/quiz/widgets/final_score_card.dart';
import 'package:quiz_app/routes/app_routes.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  bool _isGoingHome = false;

  // Scores read once from arguments in initState — never re-read in build.
  late final int _earnedPoints;
  late final int _correctAnswers;
  late final int _totalQuestions;
  late final RxInt _rxEarnedPoints;
  late final RxInt _rxCorrectAnswers;

  @override
  void initState() {
    super.initState();
    final Map<String, dynamic> args =
        Get.arguments as Map<String, dynamic>? ?? <String, dynamic>{};
    _earnedPoints = args['score'] as int? ?? 0;
    _totalQuestions = args['totalQuestions'] as int? ?? 0;
    _correctAnswers = args['correctAnswers'] as int? ?? _earnedPoints;
    _rxEarnedPoints = _earnedPoints.obs;
    _rxCorrectAnswers = _correctAnswers.obs;
  }

  // ── Navigation ─────────────────────────────────────────────────────────────

  Future<void> _goHome() async {
    if (_isGoingHome) return;
    setState(() => _isGoingHome = true);

    // Let the NEW AppShellController trigger refreshes from inside the
    // newly created shell. This avoids relying on async work started from a
    // route that is being disposed during Get.offAllNamed().
    Get.offAllNamed(
      AppRoutes.appShell,
      arguments: <String, dynamic>{'refreshAfterQuiz': true},
    );
  }

  // ── Build ──────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, void result) {
        if (didPop) return;
        _goHome();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: const CommonAppBar(
          title: 'QuizApp',
          trailingLabel: 'SESSION END',
        ),
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xxl,
                    vertical: AppSpacing.xxxl,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
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
                      // FinalScoreCard shows earned points + accuracy bar.
                      FinalScoreCard(
                        score: _rxEarnedPoints,
                        correctAnswers: _correctAnswers,
                        totalQuestions: _totalQuestions,
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      // CorrectAnswersCard shows X / totalQuestions correct.
                      CorrectAnswersCard(
                        score: _rxCorrectAnswers,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
                children: <Widget>[
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
