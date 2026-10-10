import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import 'app_colors.dart';

/// `ThemeData` untuk mode terang dan gelap, memakai font kustom Poppins.
abstract final class AppTheme {
  static ThemeData get light =>
      _build(AppColors.lightScheme, AppColors.lightBackground);

  static ThemeData get dark =>
      _build(AppColors.darkScheme, AppColors.darkBackground);

  static ThemeData _build(ColorScheme scheme, Color background) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    );

    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      fontFamily: AppAssets.fontFamily,
      scaffoldBackgroundColor: background,
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
      ),
      cardTheme: CardThemeData(
        color: scheme.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: shape,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
          shape: shape,
          textStyle: const TextStyle(
            fontFamily: AppAssets.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: scheme.primary,
          side: BorderSide(color: scheme.primary),
          shape: shape,
          textStyle: const TextStyle(
            fontFamily: AppAssets.fontFamily,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dividerColor: scheme.onSurface.withValues(alpha: 0.12),
    );
  }
}
