import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// Titik patah layout.
class AppBreakpoints {
  AppBreakpoints._();

  /// Di bawah ini dianggap layar HP.
  static const double compact = 600;

  /// Mulai lebar ini, layout dua kolom dipakai (HP landscape, tablet, web).
  static const double twoColumn = 720;

  /// Layar lebar (desktop / browser besar).
  static const double expanded = 1024;

  /// Lebar acuan untuk menghitung ukuran elemen agar tidak membengkak di
  /// layar besar.
  static const double baseWidth = 600;

  /// Lebar maksimum area konten.
  static const double maxContentWidth = 960;
}

enum ScreenSize { compact, medium, expanded }

/// Helper ukuran dinamis. Semua ukuran elemen UI dihitung dari lebar layar,
/// bukan angka piksel tetap.
extension ResponsiveContext on BuildContext {
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  ScreenSize get screenSize {
    final width = screenWidth;
    if (width < AppBreakpoints.compact) {
      return ScreenSize.compact;
    }
    if (width < AppBreakpoints.expanded) {
      return ScreenSize.medium;
    }
    return ScreenSize.expanded;
  }

  /// `true` bila layar cukup lebar untuk layout dua kolom.
  bool get useTwoColumns => screenWidth >= AppBreakpoints.twoColumn;

  double get _unit => math.min(screenWidth, AppBreakpoints.baseWidth);

  /// Pecahan dari lebar layar (dibatasi lebar acuan).
  double wp(double fraction) => _unit * fraction;

  /// Pecahan dari tinggi layar.
  double hp(double fraction) => screenHeight * fraction;

  // Jarak standar.
  double get gapS => wp(0.02);
  double get gapM => wp(0.04);
  double get gapL => wp(0.08);

  /// Radius sudut standar.
  double get radius => wp(0.035);

  double get iconSize => wp(0.06).clamp(20.0, 32.0).toDouble();

  double get buttonHeight => wp(0.14).clamp(48.0, 60.0).toDouble();
}
