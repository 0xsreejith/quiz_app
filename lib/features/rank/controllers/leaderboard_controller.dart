import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';

class LeaderboardController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<Map<String, dynamic>> scores = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();

  int get currentUserRank {
    final String? uid = _authService.currentUser?.uid;
    if (uid == null) return 0;
    final int idx = scores.indexWhere(
        (Map<String, dynamic> s) => s['uid'] == uid);
    return idx == -1 ? 0 : idx + 1;
  }

  Map<String, dynamic>? get currentUserScore {
    final String? uid = _authService.currentUser?.uid;
    if (uid == null) return null;
    try {
      return scores.firstWhere(
          (Map<String, dynamic> s) => s['uid'] == uid);
    } catch (_) {
      return null;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchLeaderboard();
  }

  Future<void> fetchLeaderboard() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final List<Map<String, dynamic>> result =
          await _firestoreService.getTopScores(limit: 50);
      scores.assignAll(result);
    } on Exception catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
