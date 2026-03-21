import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';

class ProfileController extends GetxController {
  final RxList<Map<String, dynamic>> categoryScores =
      <Map<String, dynamic>>[].obs;
  final RxBool isLoadingBadges = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadCategoryScores();
  }

  Future<void> loadCategoryScores() async {
    final AuthService authService = Get.find<AuthService>();
    final FirestoreService firestoreService = Get.find<FirestoreService>();
    final uid = authService.currentUser?.uid;

    if (uid != null) {
      try {
        final scores = await firestoreService.getCategoryScores(uid);
        categoryScores.assignAll(scores);
      } catch (e) {
        debugPrint('Error loading category scores: $e');
      }
    }
    isLoadingBadges.value = false;
  }
}
