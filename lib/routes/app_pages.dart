import 'package:get/get.dart';
import 'package:quiz_app/features/app_shell/bindings/app_shell_binding.dart';
import 'package:quiz_app/features/app_shell/views/app_shell_page.dart';
import 'package:quiz_app/features/login/views/login_page.dart';
import 'package:quiz_app/features/quiz/views/quiz_view.dart';
import 'package:quiz_app/features/splash/bindings/splash_binding.dart';
import 'package:quiz_app/features/splash/views/splash_page.dart';
import 'package:quiz_app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> pages = <GetPage<dynamic>>[
    GetPage<SplashPage>(
      name: AppRoutes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage<LoginPage>(name: AppRoutes.LOGIN, page: () => const LoginPage()),
    GetPage<AppShellPage>(
      name: AppRoutes.APP_SHELL,
      page: () => const AppShellPage(),
      binding: AppShellBinding(),
    ),
    GetPage<QuizView>(name: AppRoutes.QUIZ, page: () => const QuizView()),
  ];
}
