import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/firebase/firestore_service.dart';
import 'package:quiz_app/features/quiz/data/models/question_model.dart';
import 'package:quiz_app/features/quiz/data/services/quiz_api_service.dart';
import 'package:quiz_app/routes/app_routes.dart';

class QuizController extends GetxController {
  final QuizApiService _apiService = Get.find<QuizApiService>();

  final RxList<QuestionModel> questions = <QuestionModel>[].obs;
  final RxInt currentIndex = 0.obs;
  final RxInt score = 0.obs;
  final RxnString selectedAnswer = RxnString();
  final RxBool isLoading = false.obs;
  final RxnString errorMessage = RxnString();
  final RxBool hasAnswered = false.obs;

  QuestionModel get currentQuestion => questions[currentIndex.value];
  bool get isLastQuestion => currentIndex.value == questions.length - 1;
  int get totalQuestions => questions.length;

  @override
  void onInit() {
    super.onInit();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final List<QuestionModel> result = await _apiService.fetchQuestions();
      questions.assignAll(result);
    } on Exception catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void selectAnswer(String answer) {
    if (hasAnswered.value) return;
    selectedAnswer.value = answer;
    hasAnswered.value = true;
    if (answer == currentQuestion.correctAnswer) {
      score.value++;
    }
  }

  void nextQuestion() {
    if (isLastQuestion) {
      finishQuiz();
    } else {
      currentIndex.value++;
      selectedAnswer.value = null;
      hasAnswered.value = false;
    }
  }

  void finishQuiz() {
    Get.offNamed(AppRoutes.result);
  }

  Future<void> saveScore() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      Get.snackbar('Error', 'You must be logged in to save your score.');
      return;
    }
    try {
      final FirestoreService firestoreService = FirestoreService();
      await firestoreService.saveScore(
        uid: user.uid,
        email: user.email ?? 'Unknown',
        score: score.value,
      );
      Get.snackbar('Success', 'Score saved successfully!');
    } on Exception catch (e) {
      Get.snackbar('Error', 'Failed to save score: $e');
    }
  }

  void goHome() {
    Get.offAllNamed(AppRoutes.appShell);
  }
}
