import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:quiz_app/core/services/auth_service.dart';
import 'package:quiz_app/core/services/firestore_service.dart';
import 'package:quiz_app/features/quiz/data/models/question_model.dart';
import 'package:quiz_app/features/quiz/data/services/quiz_api_service.dart';
import 'package:quiz_app/routes/app_routes.dart';

class QuizController extends GetxController {
  final QuizApiService _apiService = Get.find<QuizApiService>();

  static const int questionTimeSeconds = 15;

  int? categoryId;
  final RxnString categoryName = RxnString();
  final RxnString categoryEmoji = RxnString();

  final RxInt timeLeft = questionTimeSeconds.obs;
  Timer? _timer;

  QuizController();

  void _parseArguments() {
    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      categoryId = args['categoryId'] as int?;
      categoryName.value = args['categoryName'] as String?;
      categoryEmoji.value = args['categoryEmoji'] as String?;
    }
  }

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

  int get correctAnswers => score.value;

  @override
  void onInit() {
    super.onInit();
    _parseArguments();
    loadQuestions();
  }

  Future<void> loadQuestions() async {
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final List<QuestionModel> result = await _apiService.fetchQuestions(
        categoryId: categoryId,
      );
      questions.assignAll(result);
      _startTimer();
    } on Exception catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    timeLeft.value = questionTimeSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft.value > 0) {
        timeLeft.value--;
      } else {
        timer.cancel();
        if (!hasAnswered.value) {
          hasAnswered.value = true;
          selectedAnswer.value = null;
        }
        Future.delayed(const Duration(seconds: 1), () {
          if (!isClosed) nextQuestion();
        });
      }
    });
  }

  void selectAnswer(String answer) {
    if (hasAnswered.value) return;
    _timer?.cancel();
    selectedAnswer.value = answer;
    hasAnswered.value = true;
    if (answer == currentQuestion.correctAnswer) {
      score.value++;
    }
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!isClosed) nextQuestion();
    });
  }

  void nextQuestion() {
    if (isLastQuestion) {
      finishQuiz();
    } else {
      currentIndex.value++;
      selectedAnswer.value = null;
      hasAnswered.value = false;
      _startTimer();
    }
  }

  Future<void> finishQuiz() async {
    _timer?.cancel();
    final AuthService authService = Get.find<AuthService>();
    final FirestoreService firestoreService = Get.find<FirestoreService>();
    final User? user = authService.currentUser;

    if (user != null) {
      try {
        // Save to global scores collection
        await firestoreService.saveScore(
          uid: user.uid,
          email: user.email ?? 'Unknown',
          score: score.value,
        );

        // Save to category scores
        if (categoryId != null) {
          await firestoreService.saveCategoryScore(
            uid: user.uid,
            categoryId: categoryId!,
            categoryName: categoryName.value ?? '',
            categoryEmoji: categoryEmoji.value ?? '',
            score: score.value,
            totalQuestions: questions.length,
          );
        }

        // Save to quiz history
        await firestoreService.saveQuizHistory(
          uid: user.uid,
          categoryName: categoryName.value ?? 'General',
          categoryEmoji: categoryEmoji.value ?? '📝',
          score: score.value,
          totalQuestions: questions.length,
          correctAnswers: correctAnswers,
        );
      } catch (e) {
        debugPrint('Error saving quiz results: $e');
      }
    }

    Get.toNamed(AppRoutes.result);
  }


  void goHome() {
    Get.offAllNamed(AppRoutes.appShell);
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
