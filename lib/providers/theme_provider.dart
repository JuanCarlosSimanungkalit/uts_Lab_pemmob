import 'package:flutter/material.dart';

/// Mengatur mode tema (terang/gelap). Awalnya mengikuti pengaturan sistem.
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  /// Membalik tema berdasarkan [current], yaitu kecerahan yang sedang tampil.
  void toggle(Brightness current) {
    _themeMode =
        current == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
