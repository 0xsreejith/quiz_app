// ignore_for_file: constant_identifier_names

abstract final class Routes {
  static const String SPLASH = '/splash';
  static const String LOGIN = '/login';
  static const String APP_SHELL = '/app-shell';
}

abstract final class AppRoutes {
  static const String SPLASH = Routes.SPLASH;
  static const String LOGIN = Routes.LOGIN;
  static const String APP_SHELL = Routes.APP_SHELL;
  static const String QUIZ = '/quiz';
}
