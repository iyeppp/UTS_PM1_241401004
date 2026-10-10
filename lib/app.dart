import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/theme/app_theme.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'widgets/theme_toggle_button.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            title: 'Kuis Arknights',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            home: const _PlaceholderHome(),
          );
        },
      ),
    );
  }
}

class _PlaceholderHome extends StatelessWidget {
  const _PlaceholderHome();

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kuis Arknights'),
        actions: const [ThemeToggleButton()],
      ),
      body: Center(child: Text('${quiz.totalQuestions} soal siap')),
    );
  }
}
