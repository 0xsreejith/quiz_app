import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/routes/app_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Get.offNamed(Routes.LOGIN);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const <Widget>[
            Icon(Icons.quiz, size: 64),
            SizedBox(height: 16),
            Text(
              'Quiz App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
