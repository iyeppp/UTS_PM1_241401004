import 'package:flutter/material.dart';

/// Menyimpan mode tema (terang/gelap/sistem) untuk seluruh aplikasi.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void setThemeMode(ThemeMode mode) {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
  }

  /// Beralih ke kebalikan dari tema yang sedang tampil.
  void toggle(Brightness current) {
    setThemeMode(current == Brightness.dark ? ThemeMode.light : ThemeMode.dark);
  }
}
