import 'dart:async';

import 'package:get/get.dart';
import 'package:quiz_app/routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    super.onReady();
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (!isClosed) {
        Get.offAllNamed(AppRoutes.LOGIN);
      }
    });
  }
}
