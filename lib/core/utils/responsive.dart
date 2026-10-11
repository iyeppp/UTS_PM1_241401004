import 'dart:math' as math;

import 'package:flutter/material.dart';

enum ScreenType { mobile, tablet, desktop }

/// Helper ukuran dinamis. Semua jarak, radius, dan ukuran font diturunkan dari
/// sisi terpendek layar (`shortestSide`), sehingga proporsional di HP, tablet,
/// web, dan tidak meledak saat layar diputar ke landscape.
///
/// Pemakaian: `final r = Responsive.of(context);` lalu `r.md`, `r.bodySize`, dll.
class Responsive {
  Responsive._(this.size, this.orientation);

  factory Responsive.of(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Responsive._(mq.size, mq.orientation);
  }

  static const double mobileBreakpoint = 600;
  static const double tabletBreakpoint = 1024;

  /// Lebar layar referensi (HP umum) untuk menghitung skala.
  static const double _referenceSide = 375;

  final Size size;
  final Orientation orientation;

  // ---- Jenis layar ----
  ScreenType get type {
    if (size.width < mobileBreakpoint) return ScreenType.mobile;
    if (size.width < tabletBreakpoint) return ScreenType.tablet;
    return ScreenType.desktop;
  }

  bool get isMobile => type == ScreenType.mobile;
  bool get isTablet => type == ScreenType.tablet;
  bool get isDesktop => type == ScreenType.desktop;
  bool get isLandscape => orientation == Orientation.landscape;
  bool get isPortrait => !isLandscape;

  /// Layout dua kolom dipakai saat landscape atau layar cukup lebar.
  bool get useTwoColumns => isLandscape || size.width >= mobileBreakpoint;

  // ---- Skala ----
  double get scale =>
      (size.shortestSide / _referenceSide).clamp(0.85, 1.5).toDouble();

  /// Lebar maksimum konten agar tidak melebar di tablet/web.
  double get maxContentWidth => switch (type) {
    ScreenType.mobile => size.width,
    ScreenType.tablet => 720,
    ScreenType.desktop => 960,
  };

  /// Lebar konten yang benar-benar terpakai.
  double get contentWidth => math.min(size.width, maxContentWidth);

  // ---- Spasi ----
  double get xs => 4 * scale;
  double get sm => 8 * scale;
  double get md => 16 * scale;
  double get lg => 24 * scale;
  double get xl => 32 * scale;
  double get xxl => 48 * scale;

  // ---- Radius ----
  double get radius => 16 * scale;

  // ---- Ukuran font ----
  double get captionSize => 12 * scale;
  double get bodySize => 14 * scale;
  double get subtitleSize => 16 * scale;
  double get titleSize => 22 * scale;
  double get headlineSize => 30 * scale;
  double get displaySize => 48 * scale;

  // ---- Ukuran ikon ----
  double get iconSize => 24 * scale;

  /// Fraksi dari tinggi layar.
  double heightFraction(double fraction) => size.height * fraction;

  /// Fraksi dari lebar konten.
  double widthFraction(double fraction) => contentWidth * fraction;
}
