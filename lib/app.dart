import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'providers/quiz_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

/// Root aplikasi. Provider diletakkan di atas `MaterialApp` agar state
/// bertahan saat rotasi dan perpindahan halaman.
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
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: themeProvider.themeMode,
            // Sementara, diganti router + QuizScreen pada Tahap 8 & 10.
            home: Builder(
              builder: (context) => HomeScreen(
                onStart: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Halaman kuis belum dibuat')),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
