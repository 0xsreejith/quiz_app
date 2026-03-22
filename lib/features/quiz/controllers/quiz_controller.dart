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
  DateTime? _quizStartTime;

  // Two-flag guard:
  // _finishQuizStarted → set true the moment finishQuiz() is entered (prevents re-entry).
  // isFinishing        → observable shown to UI as "Saving results…" overlay.
  bool _finishQuizStarted = false;
  final RxBool isFinishing = false.obs;
  bool _nextScheduled = false;

  final RxList<QuestionModel> questions = <QuestionModel>[].obs;
  final RxInt currentIndex = 0.obs;

  // score = raw correct-answer count (0–N). Used for "X/10 correct" display.
  final RxInt score = 0.obs;

  // earnedPoints = actual leaderboard points (10 pts/correct + speed bonus).
  final RxInt earnedPoints = 0.obs;

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

  void _parseArguments() {
    final dynamic args = Get.arguments;
    if (args is Map<String, dynamic>) {
      categoryId = args['categoryId'] as int?;
      categoryName.value = args['categoryName'] as String?;
      categoryEmoji.value = args['categoryEmoji'] as String?;
    }
  }

  Future<void> loadQuestions() async {
    _timer?.cancel();
    _finishQuizStarted = false;
    isFinishing.value = false;
    _nextScheduled = false;
    isLoading.value = true;
    errorMessage.value = null;
    _quizStartTime = null;
    try {
      final List<QuestionModel> result = await _apiService.fetchQuestions(
        categoryId: categoryId,
      );
      questions.assignAll(result);
      currentIndex.value = 0;
      score.value = 0;
      earnedPoints.value = 0;
      selectedAnswer.value = null;
      hasAnswered.value = false;
      _quizStartTime = DateTime.now();
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
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
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
      // Correct: increment raw count and award points with speed bonus.
      score.value++;
      final int timeBonus =
          ((timeLeft.value / questionTimeSeconds) * 5).round();
      earnedPoints.value += 10 + timeBonus;
    } else {
      HapticFeedback.vibrate();
    }
    _scheduleNextQuestion();
  }

  void _scheduleNextQuestion() {
    if (_nextScheduled) return;
    _nextScheduled = true;
    // Do NOT set isFinishing here on the last question — that would replace
    // the quiz UI before the user sees correct/wrong on the final answer.
    // isFinishing is set only when finishQuiz() runs after the same 1.5s delay.
    Future<void>.delayed(const Duration(milliseconds: 1500), () {
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
    if (_finishQuizStarted) return;
    _finishQuizStarted = true;
    isFinishing.value = true;
    _timer?.cancel();

    final AuthService authService = Get.find<AuthService>();
    final FirestoreService firestoreService = Get.find<FirestoreService>();
    final User? user = authService.currentUser;

    // Snapshot all values before any async gap.
    final int finalEarnedPoints = earnedPoints.value;
    final int finalCorrectAnswers = score.value;
    final int totalQuestionCount = questions.length;
    final String finalCategoryName = categoryName.value ?? '';
    final String finalCategoryEmoji = categoryEmoji.value ?? '';
    final int completionMs = _quizStartTime == null
        ? 0
        : DateTime.now().difference(_quizStartTime!).inMilliseconds;

    if (user != null) {
      try {
        // saveScore must complete first — it writes the aggregate document
        // that saveCategoryScore and saveQuizHistory do NOT depend on.
        await firestoreService.saveScore(
          uid: user.uid,
          email: user.email ?? 'unknown@unknown.com',
          earnedScore: finalEarnedPoints,
          correctAnswers: finalCorrectAnswers,
          totalQuestions: totalQuestionCount,
          completionMs: completionMs,
          displayName:
              user.displayName ??
              (user.email?.split('@').first ?? 'Unknown'),
        );

        // saveCategoryScore and saveQuizHistory are independent — run in parallel.
        await Future.wait<void>(<Future<void>>[
          if (categoryId != null)
            firestoreService.saveCategoryScore(
              uid: user.uid,
              categoryId: categoryId!,
              categoryName: finalCategoryName,
              categoryEmoji: finalCategoryEmoji,
              score: finalEarnedPoints,
              correctAnswers: finalCorrectAnswers,
              totalQuestions: totalQuestionCount,
            ),
          firestoreService.saveQuizHistory(
            uid: user.uid,
            categoryName: finalCategoryName.isNotEmpty
                ? finalCategoryName
                : 'General',
            categoryEmoji: finalCategoryEmoji.isNotEmpty
                ? finalCategoryEmoji
                : '📝',
            score: finalEarnedPoints,
            totalQuestions: totalQuestionCount,
            correctAnswers: finalCorrectAnswers,
          ),
        ]);
      } catch (e) {
        debugPrint('Error saving quiz results: $e');
      }
    }

    // All Firestore writes are complete. Navigate to result.
    Get.offNamed(
      AppRoutes.result,
      arguments: <String, dynamic>{
        'score': finalEarnedPoints,
        'totalQuestions': totalQuestionCount,
        'correctAnswers': finalCorrectAnswers,
      },
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
