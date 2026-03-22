import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';

class ProfileController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingBadges = true.obs;
  final RxInt totalPlayed = 0.obs;
  final RxInt bestScore = 0.obs;
  final RxInt avgAccuracy = 0.obs;
  final RxList<Map<String, dynamic>> categoryScores =
      <Map<String, dynamic>>[].obs;

  String get email => _authService.currentUser?.email ?? '';
  String get displayName => email.split('@').first.toUpperCase();

  Map<String, dynamic>? get bestCategory =>
      categoryScores.isEmpty ? null : categoryScores.first;

  Map<String, dynamic>? get dominantCategory {
    if (categoryScores.isEmpty) return null;
    return categoryScores.reduce(
      (Map<String, dynamic> a, Map<String, dynamic> b) =>
          (a['totalAttempts'] as int? ?? 0) > (b['totalAttempts'] as int? ?? 0)
          ? a
          : b,
    );
  }

  @override
  void onInit() {
    super.onInit();
    loadProfileData();
  }

  Future<void> loadProfileData() async {
    isLoading.value = true;
    isLoadingBadges.value = true;
    try {
      final String? uid = _authService.currentUser?.uid;
      if (uid == null) return;

      final Map<String, dynamic> stats = await _firestoreService.getUserStats(
        uid,
      );
      totalPlayed.value = stats['totalPlayed'] as int? ?? 0;
      bestScore.value = stats['bestScore'] as int? ?? 0;
      avgAccuracy.value = stats['avgAccuracy'] as int? ?? 0;

      final List<Map<String, dynamic>> catScores = await _firestoreService
          .getCategoryScores(uid);
      categoryScores.assignAll(catScores);
    } catch (e) {
      debugPrint('Error loading profile data: $e');
    } finally {
      isLoading.value = false;
      isLoadingBadges.value = false;
    }
  }

  Future<void> refreshAfterQuiz() => loadProfileData();
}
