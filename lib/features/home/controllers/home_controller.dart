import 'package:get/get.dart';
import 'package:quiz_app/routes/app_routes.dart';

class HomeController extends GetxController {
  void startQuiz() {
    Get.toNamed(AppRoutes.quiz);
  }
}