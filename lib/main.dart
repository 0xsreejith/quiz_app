import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/firebase_options.dart';
import 'package:quiz_app/modules/auth/controller/auth_binding.dart';
import 'package:quiz_app/routes/app_pages.dart';
import 'package:quiz_app/routes/app_routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Quiz App',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.SPLASH,
      initialBinding: AuthBinding(),
      getPages: AppPages.routes,
    );
  }
}
