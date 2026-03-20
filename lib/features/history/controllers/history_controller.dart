import 'package:get/get.dart';

class HistoryController extends GetxController {
  final RxList<Map<String, dynamic>> quizHistory = <Map<String, dynamic>>[].obs;
  final RxBool isLoading = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }
  
  Future<void> loadHistory() async {
    isLoading.value = true;
    try {
      // Load quiz history from storage/API
      await Future.delayed(const Duration(milliseconds: 500)); // Simulate loading
      // quizHistory.assignAll(await historyService.getHistory());
    } catch (e) {
      // Handle error
    } finally {
      isLoading.value = false;
    }
  }
  
  void clearHistory() {
    quizHistory.clear();
  }
}