import 'package:get/get.dart';

/// Minimal controller for Settings feature.
/// Holds local UI state only — no backend logic.
class SettingsController extends GetxController {
  // Interface / Display
  final RxBool isDarkMode = false.obs;

  // Push Notifications
  final RxBool quizReminders = true.obs;
  final RxBool leaderboardShifts = false.obs;
}
