import 'package:flutter/material.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

class QuizBottomBar extends StatelessWidget {
  const QuizBottomBar({super.key});

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
    );
  }
}
