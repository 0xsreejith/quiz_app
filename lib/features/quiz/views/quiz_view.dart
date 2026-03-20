import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/quiz/controllers/quiz_controller.dart';
import 'package:quiz_app/features/quiz/widgets/option_tile.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorMessage.value != null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    controller.errorMessage.value!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: controller.loadQuestions,
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        if (controller.questions.isEmpty) {
          return const Center(child: Text('No questions available.'));
        }

        final question = controller.currentQuestion;
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Progress indicator
              LinearProgressIndicator(
                value: (controller.currentIndex.value + 1) /
                    controller.totalQuestions,
                backgroundColor: Colors.grey.shade200,
                minHeight: 6,
              ),
              const SizedBox(height: 12),
              Text(
                'Question ${controller.currentIndex.value + 1} of ${controller.totalQuestions}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 20),

              // Question text
              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 24),

              // Options
              ...question.options.map(
                (String option) => OptionTile(
                  option: option,
                  isSelected: controller.selectedAnswer.value == option,
                  isCorrect: option == question.correctAnswer,
                  hasAnswered: controller.hasAnswered.value,
                  onTap: () => controller.selectAnswer(option),
                ),
              ),

              const Spacer(),

              // Next / Finish button
              Obx(
                () => ElevatedButton(
                  onPressed:
                      controller.hasAnswered.value
                          ? controller.nextQuestion
                          : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    controller.isLastQuestion ? 'Finish' : 'Next',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
