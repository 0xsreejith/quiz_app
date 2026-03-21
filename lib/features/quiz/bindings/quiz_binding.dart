import 'package:get/get.dart';
import 'package:quiz_app/features/quiz/controllers/quiz_controller.dart';
import 'package:quiz_app/features/quiz/data/services/quiz_api_service.dart';

class QuizBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QuizApiService>(QuizApiService.new);
    Get.lazyPut<QuizController>(() => QuizController());
  }
}
