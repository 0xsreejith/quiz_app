import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';

class HistoryController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<Map<String, dynamic>> quizHistory = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  /// Authoritative stats from the user-stats document (not the capped list).
  final RxInt totalPlayedStat = 0.obs;
  final RxInt avgAccuracyStat = 0.obs;

  int get bestScore => quizHistory.isEmpty
      ? 0
      : quizHistory
          .map((Map<String, dynamic> h) => h['score'] as int? ?? 0)
          .reduce((int a, int b) => a > b ? a : b);

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final String? uid = _authService.currentUser?.uid;
      if (uid == null) {
        isLoading.value = false;
        errorMessage.value = 'Not logged in';
        return;
      }

      final List<Object> results = await Future.wait(<Future<Object>>[
        _firestoreService.getQuizHistory(uid),
        _firestoreService.getUserStats(uid),
      ]);

      quizHistory.assignAll(results[0] as List<Map<String, dynamic>>);

      final Map<String, dynamic> stats = results[1] as Map<String, dynamic>;
      totalPlayedStat.value = stats['totalPlayed'] as int? ?? 0;
      avgAccuracyStat.value = stats['avgAccuracy'] as int? ?? 0;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshHistory() => loadHistory();

  void clearHistory() {
    quizHistory.clear();
  }
}