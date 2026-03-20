import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/quiz/controllers/quiz_controller.dart';

class ResultPage extends GetView<QuizController> {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Results'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.emoji_events,
                size: 80,
                color: Colors.amber,
              ),
              const SizedBox(height: 24),
              const Text(
                'Quiz Completed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Obx(
                () => Text(
                  'You scored ${controller.score.value} / ${controller.totalQuestions}',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: controller.saveScore,
                  icon: const Icon(Icons.save),
                  label: const Text('Save Score'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: controller.goHome,
                  icon: const Icon(Icons.home),
                  label: const Text('Go Home'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
