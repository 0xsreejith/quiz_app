import 'package:flutter/material.dart';
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
    return PopScope<void>(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, void result) async {
        if (didPop) return;
        await _showExitConfirmationDialog(context);
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        appBar: CommonAppBar(
          title: 'QuizApp',
          trailingLabel: 'QUIT QUIZ',
          onTrailingTap: () => _showExitConfirmationDialog(context),
          isRedTrailing: true,
        ),
        body: SafeArea(
          child: Obx(() {
            if (controller.isFinishing.value) {
              return const Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(color: AppColors.primary),
                    SizedBox(height: 20),
                    Text(
                      'Saving results...',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              );
            }

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
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
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
                          ...question.options.asMap().entries.map((entry) {
                            final int index = entry.key;
                            final String optionStr = entry.value;
                            final String letter = String.fromCharCode(
                              65 + index,
                            );
                            return Padding(
                              padding: const EdgeInsets.only(
                                bottom: AppSpacing.lg,
                              ),
                              child: OptionTile(
                                letter: letter,
                                option: optionStr,
                                isSelected:
                                    controller.selectedAnswer.value ==
                                    optionStr,
                                isCorrect:
                                    controller.hasAnswered.value &&
                                    question.isCorrectOption(optionStr),
                                hasAnswered: controller.hasAnswered.value,
                                onTap: () => controller.selectAnswer(optionStr),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                const QuizBottomBar(),
              ],
            );
          }),
        ),
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
            const Icon(
              Icons.wifi_off_rounded,
              size: 56,
              color: AppColors.textMuted,
            ),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              'Unable to load quiz questions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textDarkest,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              controller.errorMessage.value!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textMuted,
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            ElevatedButton(
              onPressed: controller.loadQuestions,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 0,
              ),
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showExitConfirmationDialog(BuildContext context) async {
    if (Get.isDialogOpen ?? false) return;

    final bool shouldQuit =
        await showDialog<bool>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: const Text('Quit quiz?'),
              content: const Text(
                'Your current progress will be lost if you leave this quiz now.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(false),
                  child: const Text('Stay'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(true),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red.shade700,
                  ),
                  child: const Text('Quit'),
                ),
              ],
            );
          },
        ) ??
        false;

    if (shouldQuit) {
      controller.goHome();
    }
  }
}
