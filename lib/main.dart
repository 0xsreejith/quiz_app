import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/routes/app_pages.dart';
import 'package:quiz_app/routes/app_routes.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.SPLASH,
      getPages: AppPages.pages,
    );
  }
}
