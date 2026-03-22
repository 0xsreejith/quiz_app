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

  int _loadGen = 0;

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

  Future<void> loadHistory({bool fromServer = false}) async {
    final int gen = ++_loadGen;
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final String? uid = _authService.currentUser?.uid;
      if (uid == null) {
        if (gen == _loadGen) {
          isLoading.value = false;
          errorMessage.value = 'Not logged in';
        }
        return;
      }

      final List<Object> results = await Future.wait(<Future<Object>>[
        _firestoreService.getQuizHistory(uid, fromServer: fromServer),
        _firestoreService.getUserStats(uid, fromServer: fromServer),
      ]);

      if (gen != _loadGen) return;
      quizHistory.assignAll(results[0] as List<Map<String, dynamic>>);

      final Map<String, dynamic> stats = results[1] as Map<String, dynamic>;
      totalPlayedStat.value = (stats['totalPlayed'] as num?)?.toInt() ?? 0;
      avgAccuracyStat.value = (stats['avgAccuracy'] as num?)?.round() ?? 0;
    } catch (e) {
      if (gen == _loadGen) {
        errorMessage.value = e.toString();
      }
    } finally {
      if (gen == _loadGen) {
        isLoading.value = false;
      }
    }
  }

  Future<void> refreshHistory() => loadHistory(fromServer: true);

  void clearHistory() {
    quizHistory.clear();
  }
}
