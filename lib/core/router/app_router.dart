import 'package:flutter/material.dart';

import '../../screens/home_screen.dart';
import '../../screens/quiz_screen.dart';
import '../../screens/result_screen.dart';

/// Nama-nama route aplikasi.
abstract final class AppRoutes {
  static const String home = '/';
  static const String quiz = '/quiz';
  static const String result = '/result';
}

/// Menentukan halaman yang dibuka untuk tiap route.
abstract final class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.quiz:
        return MaterialPageRoute(builder: (_) => const QuizScreen());
      case AppRoutes.result:
        return MaterialPageRoute(builder: (_) => const ResultScreen());
      case AppRoutes.home:
      default:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(
            onStart: () => Navigator.pushNamed(context, AppRoutes.quiz),
          ),
        );
    }
  }
}
