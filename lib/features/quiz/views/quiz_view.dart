import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';
import 'package:quiz_app/core/widgets/common_app_bar.dart';
import 'package:quiz_app/features/quiz/controllers/quiz_controller.dart';
import 'package:quiz_app/features/quiz/widgets/option_tile.dart';
import 'package:quiz_app/features/quiz/widgets/quiz_bottom_bar.dart';
import 'package:quiz_app/features/quiz/widgets/quiz_progress_header.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: CommonAppBar(
        title: 'QuizApp',
        trailingLabel: 'QUIT QUIZ',
        onTrailingTap: Get.back,
        isRedTrailing: true,
      ),
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.errorMessage.value != null) {
            return _buildErrorState();
          }

          if (controller.questions.isEmpty) {
            return const Center(child: Text('No questions available.'));
          }

          final question = controller.currentQuestion;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: AppSpacing.cardPaddingLarge,
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(0.05, 0),
                            end: Offset.zero,
                          ).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    child: Column(
                      key: ValueKey<int>(controller.currentIndex.value),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        QuizProgressHeader(controller: controller),
                        const SizedBox(height: 40),
                        Text(
                          question.question,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDarkest,
                            height: 1.3,
                          ),
                        ),

                        const SizedBox(height: 40),
                        ...question.options.asMap().entries.map(
                          (entry) {
                            final int index = entry.key;
                            final String optionStr = entry.value;
                            final String letter = String.fromCharCode(65 + index); // A, B, C, D
                            return Padding(
                              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
                              child: OptionTile(
                                letter: letter,
                                option: optionStr,
                                isSelected: controller.selectedAnswer.value == optionStr,
                                isCorrect: optionStr == question.correctAnswer,
                                hasAnswered: controller.hasAnswered.value,
                                onTap: () {
                                  controller.selectAnswer(optionStr);
                                  if (optionStr != question.correctAnswer) {
                                    HapticFeedback.vibrate();
                                  }
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              QuizBottomBar(controller: controller),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: AppSpacing.cardPaddingLarge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: AppSpacing.lg),
            Text(
              controller.errorMessage.value!,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(
              onPressed: controller.loadQuestions,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}
