import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/routes/app_routes.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              'Quiz App',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Get.offAllNamed(Routes.APP_SHELL),
              child: const Text('Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
