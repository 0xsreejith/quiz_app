import 'package:get/get.dart';
import 'package:quiz_app/features/app_shell/bindings/app_shell_binding.dart';
import 'package:quiz_app/features/app_shell/views/app_shell_page.dart';
import 'package:quiz_app/features/quiz/bindings/quiz_binding.dart';
import 'package:quiz_app/features/quiz/views/quiz_view.dart';
import 'package:quiz_app/features/quiz/views/result_page.dart';
import 'package:quiz_app/features/splash/bindings/splash_binding.dart';
import 'package:quiz_app/features/splash/views/splash_page.dart';
import 'package:quiz_app/features/auth/login/login_page.dart';
import 'package:quiz_app/features/auth/signup/signup_page.dart';
import 'package:quiz_app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashPage>(
      name: AppRoutes.splash,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage<LoginPage>(name: AppRoutes.login, page: () => const LoginPage()),
    GetPage<SignupPage>(name: AppRoutes.signup, page: () => const SignupPage()),
    GetPage<AppShellPage>(
      name: AppRoutes.appShell,
      page: () => const AppShellPage(),
      binding: AppShellBinding(),
    ),
    GetPage<QuizView>(
      name: AppRoutes.quiz,
      page: () => const QuizView(),
      binding: QuizBinding(),
    ),
    GetPage<ResultPage>(
      name: AppRoutes.result,
      page: () => const ResultPage(),
    ),
  ];
}
