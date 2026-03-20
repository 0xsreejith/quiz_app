import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/history/controllers/history_controller.dart';

class HistoryPage extends GetView<HistoryController> {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      
      if (controller.quizHistory.isEmpty) {
        return const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.history, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No quiz history yet',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
              SizedBox(height: 8),
              Text(
                'Complete some quizzes to see your history here',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      }
      
      return ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: controller.quizHistory.length,
        itemBuilder: (context, index) {
          final quiz = controller.quizHistory[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.quiz),
              title: Text('Quiz ${index + 1}'),
              subtitle: Text('Score: ${quiz['score'] ?? 0}'),
              trailing: Text(quiz['date'] ?? ''),
            ),
          );
        },
      );
    });
  }
}