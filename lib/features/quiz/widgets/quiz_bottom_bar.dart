import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/features/quiz/controllers/quiz_controller.dart';

class QuizBottomBar extends StatelessWidget {
  const QuizBottomBar({required this.controller, super.key});

  final QuizController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.searchBarBg,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Icon(Icons.flag_rounded, color: Colors.grey.shade500, size: 16),
              const SizedBox(width: 8),
              Text(
                'REPORT\nISSUE',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade500,
                  letterSpacing: 0.5,
                  height: 1.2,
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Obx(() => ElevatedButton(
              onPressed: controller.hasAnswered.value ? controller.nextQuestion : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                elevation: 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.isLastQuestion ? 'FINISH' : 'SUBMIT ANSWER',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            )),
          ),
        ],
      ),
    );
  }
}
