import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';
import 'package:quiz_app/features/app_shell/controllers/app_shell_controller.dart';
import 'package:quiz_app/features/auth/controllers/auth_controller.dart';
import 'package:quiz_app/features/home/bindings/home_binding.dart';
import 'package:quiz_app/features/live/bindings/live_binding.dart';
import 'package:quiz_app/features/rank/bindings/rank_binding.dart';
import 'package:quiz_app/features/history/bindings/history_binding.dart';
import 'package:quiz_app/features/profile/bindings/profile_binding.dart';

class AppShellBinding extends Bindings {
  @override
  void dependencies() {
    // ── Core services ────────────────────────────────────────────────
    // lazyPut + fenix: reuses an existing instance if AuthBinding already
    // registered it (first launch), and safely recreates it on subsequent
    // navigations after Get.offAllNamed() disposes the previous context.
    Get.lazyPut<AuthService>(AuthService.new, fenix: true);
    Get.lazyPut<FirestoreService>(FirestoreService.new, fenix: true);

    // ── AuthController ───────────────────────────────────────────────
    // Required by ProfilePage, SettingsPage and any shell widget that calls
    // Get.find<AuthController>(). Must be registered here because
    // AppShellBinding is the active binding once the shell route loads.
    Get.lazyPut<AuthController>(
      () => AuthController(
        authService: Get.find<AuthService>(),
        firestoreService: Get.find<FirestoreService>(),
      ),
      fenix: true,
    );

    // ── Shell controller ─────────────────────────────────────────────
    Get.lazyPut<AppShellController>(AppShellController.new);

    // ── Feature controllers (each binding uses lazyPut internally) ───
    HomeBinding().dependencies();
    LiveBinding().dependencies();
    RankBinding().dependencies();
    HistoryBinding().dependencies();
    ProfileBinding().dependencies();
  }
}