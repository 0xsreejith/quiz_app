import 'package:get/get.dart';
import 'package:quiz_app/features/app_shell/bindings/app_shell_binding.dart';
import 'package:quiz_app/features/app_shell/views/app_shell_page.dart';
import 'package:quiz_app/features/categories/bindings/categories_binding.dart';
import 'package:quiz_app/features/categories/views/categories_page.dart';
import 'package:quiz_app/features/live/views/live_page.dart';
import 'package:quiz_app/features/profile/views/profile_page.dart';
import 'package:quiz_app/features/settings/controllers/settings_controller.dart';
import 'package:quiz_app/features/settings/views/settings_page.dart';
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
    GetPage<ResultPage>(name: AppRoutes.result, page: () => const ResultPage()),
    GetPage<LivePage>(
      name: AppRoutes.liveSession,
      page: () => const LivePage(),
    ),
    GetPage<ProfilePage>(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
    ),
    GetPage<CategoriesPage>(
      name: AppRoutes.categories,
      page: () => const CategoriesPage(),
      binding: CategoriesBinding(),
    ),
    GetPage<SettingsPage>(
      name: AppRoutes.settings,
      page: () => const SettingsPage(),
      // Inline binding: registers SettingsController once at route entry,
      // not on every build() call. This fixes the Get.put()-in-build() bug.
      binding: BindingsBuilder<void>(
        () => Get.lazyPut<SettingsController>(SettingsController.new),
      ),
    ),
  ];
}