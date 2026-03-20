import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/routes/app_routes.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text('Home Page'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.QUIZ),
              child: const Text('Start Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}
