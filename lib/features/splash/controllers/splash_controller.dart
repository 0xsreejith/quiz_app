import 'package:get/get.dart';
import 'package:quiz_app/core/firebase/auth_service.dart';
import 'package:quiz_app/routes/app_routes.dart';

class SplashController extends GetxController {
  SplashController({required AuthService authService})
    : _authService = authService;

  final AuthService _authService;

  @override
  Future<void> onReady() async {
    super.onReady();

    await Future<void>.delayed(const Duration(seconds: 2));
    if (isClosed) {
      return;
    }

    final bool isLoggedIn = _authService.currentUser != null;
    final String targetRoute = isLoggedIn
        ? AppRoutes.APP_SHELL
        : AppRoutes.LOGIN;
    Get.offAllNamed(targetRoute);
  }
}
