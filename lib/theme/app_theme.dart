import 'package:flutter/material.dart';

/// Warna status jawaban yang tidak tersedia di [ColorScheme].
@immutable
class QuizColors extends ThemeExtension<QuizColors> {
  const QuizColors({
    required this.correct,
    required this.correctContainer,
    required this.wrong,
    required this.wrongContainer,
  });

  final Color correct;
  final Color correctContainer;
  final Color wrong;
  final Color wrongContainer;

  static const QuizColors light = QuizColors(
    correct: Color(0xFF1B8A4B),
    correctContainer: Color(0xFFD7F5E3),
    wrong: Color(0xFFC62828),
    wrongContainer: Color(0xFFFFE0DE),
  );

  static const QuizColors dark = QuizColors(
    correct: Color(0xFF66D19A),
    correctContainer: Color(0xFF11382A),
    wrong: Color(0xFFFF8A80),
    wrongContainer: Color(0xFF4A1F1D),
  );

  @override
  QuizColors copyWith({
    Color? correct,
    Color? correctContainer,
    Color? wrong,
    Color? wrongContainer,
  }) {
    return QuizColors(
      correct: correct ?? this.correct,
      correctContainer: correctContainer ?? this.correctContainer,
      wrong: wrong ?? this.wrong,
      wrongContainer: wrongContainer ?? this.wrongContainer,
    );
  }

  @override
  QuizColors lerp(ThemeExtension<QuizColors>? other, double t) {
    if (other is! QuizColors) {
      return this;
    }
    return QuizColors(
      correct: Color.lerp(correct, other.correct, t)!,
      correctContainer: Color.lerp(correctContainer, other.correctContainer, t)!,
      wrong: Color.lerp(wrong, other.wrong, t)!,
      wrongContainer: Color.lerp(wrongContainer, other.wrongContainer, t)!,
    );
  }
}

/// Tema aplikasi: Material 3, dua varian (terang dan gelap) dari satu warna
/// benih, dengan font kustom Poppins (judul) dan Nunito (isi).
class AppTheme {
  AppTheme._();

  static const Color seed = Color(0xFF5B5BD6);
  static const String headingFont = 'Poppins';
  static const String bodyFont = 'Nunito';

  static ThemeData get light => _build(Brightness.light);
  static ThemeData get dark => _build(Brightness.dark);

  static ThemeData _build(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: seed,
      brightness: brightness,
    );
    final base = ThemeData(useMaterial3: true, colorScheme: scheme);

    final body = base.textTheme.apply(
      fontFamily: bodyFont,
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
    );

    TextStyle heading(TextStyle? style, FontWeight weight) {
      return (style ?? const TextStyle()).copyWith(
        fontFamily: headingFont,
        fontWeight: weight,
      );
    }

    final textTheme = body.copyWith(
      headlineLarge: heading(body.headlineLarge, FontWeight.w700),
      headlineMedium: heading(body.headlineMedium, FontWeight.w700),
      headlineSmall: heading(body.headlineSmall, FontWeight.w600),
      titleLarge: heading(body.titleLarge, FontWeight.w600),
      titleMedium: heading(body.titleMedium, FontWeight.w600),
    );

    return base.copyWith(
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,
      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge,
      ),
      extensions: [
        brightness == Brightness.light ? QuizColors.light : QuizColors.dark,
      ],
    );
  }
}
