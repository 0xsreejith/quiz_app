import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quiz_app/features/auth/controller/auth_controller.dart';

class ProfilePage extends GetView<AuthController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text(
                'Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              Text(
                controller.currentUserEmail.isEmpty
                    ? 'No email available'
                    : controller.currentUserEmail,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 180,
                child: ElevatedButton.icon(
                  onPressed: controller.logout,
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
