import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';

class HistoryController extends GetxController {
  final FirestoreService _firestoreService = Get.find<FirestoreService>();
  final AuthService _authService = Get.find<AuthService>();

  final RxList<Map<String, dynamic>> quizHistory = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  int get totalPlayed => quizHistory.length;
  int get bestScore => quizHistory.isEmpty
      ? 0
      : quizHistory
          .map((Map<String, dynamic> h) => h['score'] as int? ?? 0)
          .reduce((int a, int b) => a > b ? a : b);
  int get avgAccuracy => quizHistory.isEmpty
      ? 0
      : (quizHistory
                  .map((Map<String, dynamic> h) => h['accuracy'] as int? ?? 0)
                  .reduce((int a, int b) => a + b) /
              quizHistory.length)
          .round();

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
        errorMessage.value = 'Not logged in';
        return;
      }
      final List<Map<String, dynamic>> data =
          await _firestoreService.getQuizHistory(uid);
      quizHistory.assignAll(data);
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