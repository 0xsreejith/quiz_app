import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/services/firestore_service.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/features/auth/bindings/auth_binding.dart';
import 'package:quiz_app/routes/app_pages.dart';
import 'package:quiz_app/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  try {
    final FirestoreService firestoreService = FirestoreService();
    await firestoreService.migrateScoresToTotalScore();
  } catch (error) {
    debugPrint('Score migration v2 failed: $error');
  }
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      initialBinding: AuthBinding(),
      getPages: AppPages.routes,
    );
  }
}
