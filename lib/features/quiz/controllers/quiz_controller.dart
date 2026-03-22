import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
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
  bool _isFinishing = false;
  bool _nextScheduled = false;

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
    _timer?.cancel();
    _isFinishing = false;
    _nextScheduled = false;
    isLoading.value = true;
    errorMessage.value = null;
    try {
      final List<QuestionModel> result = await _apiService.fetchQuestions(
        categoryId: categoryId,
      );
      questions.assignAll(result);
      currentIndex.value = 0;
      score.value = 0;
      selectedAnswer.value = null;
      hasAnswered.value = false;
      _startTimer();
    } on Exception catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void _startTimer() {
    _timer?.cancel();
    _nextScheduled = false;
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
        _scheduleNextQuestion();
      }
    });
  }

  void selectAnswer(String answer) {
    if (hasAnswered.value) return;
    _timer?.cancel();
    selectedAnswer.value = answer;
    hasAnswered.value = true;
    if (currentQuestion.checkAnswer(answer)) {
      score.value++;
    } else {
      HapticFeedback.vibrate();
    }
    _scheduleNextQuestion();
  }

  void _scheduleNextQuestion() {
    if (_nextScheduled) return;
    _nextScheduled = true;
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!isClosed) {
        _nextScheduled = false;
        nextQuestion();
      }
    });
  }

  void nextQuestion() {
    if (!hasAnswered.value) return;
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
    if (_isFinishing) return;
    _isFinishing = true;
    _timer?.cancel();
    final AuthService authService = Get.find<AuthService>();
    final FirestoreService firestoreService = Get.find<FirestoreService>();
    final User? user = authService.currentUser;
    final int finalScore = score.value;
    final int totalQuestionCount = questions.length;
    final int finalCorrectAnswers = correctAnswers;
    final String finalCategoryName = categoryName.value ?? '';
    final String finalCategoryEmoji = categoryEmoji.value ?? '';

    if (user != null) {
      try {
        // Save to global scores collection
        await firestoreService.saveScore(
          uid: user.uid,
          email: user.email ?? 'Unknown',
          score: finalScore,
          displayName:
              user.displayName ?? (user.email?.split('@').first ?? 'Unknown'),
        );

        // Save to category scores
        if (categoryId != null) {
          await firestoreService.saveCategoryScore(
            uid: user.uid,
            categoryId: categoryId!,
            categoryName: finalCategoryName,
            categoryEmoji: finalCategoryEmoji,
            score: finalScore,
            totalQuestions: totalQuestionCount,
          );
        }

        // Save to quiz history
        await firestoreService.saveQuizHistory(
          uid: user.uid,
          categoryName: finalCategoryName.isNotEmpty
              ? finalCategoryName
              : 'General',
          categoryEmoji: finalCategoryEmoji.isNotEmpty
              ? finalCategoryEmoji
              : '📝',
          score: finalScore,
          totalQuestions: totalQuestionCount,
          correctAnswers: finalCorrectAnswers,
        );
      } catch (e) {
        debugPrint('Error saving quiz results: $e');
      }
    }

    Get.offNamed(
      AppRoutes.result,
      arguments: {'score': finalScore, 'totalQuestions': totalQuestionCount},
    );
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
