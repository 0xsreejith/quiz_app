import 'package:get/get.dart';
import 'package:quiz_app/features/app_shell/views/app_shell.dart';
import 'package:quiz_app/features/login/views/login_page.dart';
import 'package:quiz_app/features/splash/views/splash_page.dart';
import 'package:quiz_app/routes/app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
    GetPage<SplashPage>(name: Routes.SPLASH, page: () => const SplashPage()),
    GetPage<LoginPage>(name: Routes.LOGIN, page: () => const LoginPage()),
    GetPage<AppShell>(name: Routes.APP_SHELL, page: () => const AppShell()),
  ];
}
