import 'package:flutter/material.dart';

/// Palet warna aplikasi (terinspirasi nuansa Arknights: biru-kyan & abu gelap).
abstract final class AppColors {
  // Semantik (sama di kedua tema)
  static const Color correct = Color(0xFF2E9E6B);
  static const Color wrong = Color(0xFFD9534F);

  // Light
  static const Color lightPrimary = Color(0xFF0288D1);
  static const Color lightOnPrimary = Color(0xFFFFFFFF);
  static const Color lightSecondary = Color(0xFFF9A825);
  static const Color lightOnSecondary = Color(0xFF1B1B1F);
  static const Color lightBackground = Color(0xFFF3F6FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightOnSurface = Color(0xFF1B1F27);

  // Dark
  static const Color darkPrimary = Color(0xFF4FC3F7);
  static const Color darkOnPrimary = Color(0xFF00283B);
  static const Color darkSecondary = Color(0xFFFFCA28);
  static const Color darkOnSecondary = Color(0xFF1B1B1F);
  static const Color darkBackground = Color(0xFF12151B);
  static const Color darkSurface = Color(0xFF1D222B);
  static const Color darkOnSurface = Color(0xFFE6EAF0);

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,
    primary: lightPrimary,
    onPrimary: lightOnPrimary,
    secondary: lightSecondary,
    onSecondary: lightOnSecondary,
    error: wrong,
    onError: Colors.white,
    surface: lightSurface,
    onSurface: lightOnSurface,
  );

  static const ColorScheme darkScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: darkPrimary,
    onPrimary: darkOnPrimary,
    secondary: darkSecondary,
    onSecondary: darkOnSecondary,
    error: wrong,
    onError: Colors.white,
    surface: darkSurface,
    onSurface: darkOnSurface,
  );
}
