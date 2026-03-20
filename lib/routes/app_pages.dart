import 'package:get/get.dart';
import 'package:quiz_app/features/app_shell/bindings/app_shell_binding.dart';
import 'package:quiz_app/features/quiz/views/quiz_view.dart';
import 'package:quiz_app/features/splash/bindings/splash_binding.dart';
import 'package:quiz_app/features/splash/views/splash_page.dart';
import 'package:quiz_app/modules/auth/login/login_page.dart';
import 'package:quiz_app/modules/auth/signup/signup_page.dart';
import 'package:quiz_app/modules/home/home_page.dart';
import 'package:quiz_app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashPage>(
      name: Routes.SPLASH,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage<LoginPage>(name: Routes.LOGIN, page: () => const LoginPage()),
    GetPage<SignupPage>(name: Routes.SIGNUP, page: () => const SignupPage()),
    GetPage<HomeModulePage>(
      name: Routes.APP_SHELL,
      page: () => const HomeModulePage(),
      binding: AppShellBinding(),
    ),
    GetPage<QuizView>(name: Routes.QUIZ, page: () => const QuizView()),
  ];
}
