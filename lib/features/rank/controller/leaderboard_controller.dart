import 'package:get/get.dart';
import 'package:quiz_app/core/firebase/firestore_service.dart';

class LeaderboardController extends GetxController {
  final FirestoreService _firestoreService = FirestoreService();

  final RxList<Map<String, dynamic>> scores = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();

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
          await _firestoreService.getTopScores();
      scores.assignAll(result);
    } on Exception catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}
