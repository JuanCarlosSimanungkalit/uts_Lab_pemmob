import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/providers/quiz_provider.dart';
import 'package:quiz_app/screens/quiz_screen.dart';

/// Mensimulasikan layar HP potret.
void usePhoneSize(WidgetTester tester) {
  tester.view.physicalSize = const Size(400, 800);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
}

Future<void> startQuiz(WidgetTester tester, String name) async {
  await tester.pumpWidget(const QuizApp());
  await tester.enterText(find.byType(TextFormField), name);
  await tester.tap(find.text('Mulai Kuis'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Welcome menolak nama kosong', (tester) async {
    usePhoneSize(tester);
    await tester.pumpWidget(const QuizApp());

    await tester.tap(find.text('Mulai Kuis'));
    await tester.pump();

    expect(find.text('Nama tidak boleh kosong'), findsOneWidget);
    expect(find.byType(QuizScreen), findsNothing);
  });

  testWidgets('nama valid membuka halaman kuis soal pertama', (tester) async {
    usePhoneSize(tester);
    await startQuiz(tester, 'Budi');

    expect(find.byType(QuizScreen), findsOneWidget);
    expect(find.text('Soal 1 dari 10'), findsOneWidget);
    expect(find.text('Halo, Budi'), findsOneWidget);
  });

  testWidgets('memilih jawaban menyimpannya di provider', (tester) async {
    usePhoneSize(tester);
    await startQuiz(tester, 'Budi');

    final option = find.text(quizQuestions[0].options[1]);
    await tester.ensureVisible(option);
    await tester.tap(option);
    await tester.pump();

    final quiz = Provider.of<QuizProvider>(
      tester.element(find.byType(QuizScreen)),
      listen: false,
    );
    expect(quiz.answers[0], 1);
  });

  testWidgets('jawaban tidak hilang ketika layar dirotasi', (tester) async {
    usePhoneSize(tester);
    await startQuiz(tester, 'Budi');

    final option = find.text(quizQuestions[0].options[1]);
    await tester.ensureVisible(option);
    await tester.tap(option);
    await tester.pump();

    // Rotasi ke landscape.
    tester.view.physicalSize = const Size(800, 400);
    await tester.pumpAndSettle();

    final quiz = Provider.of<QuizProvider>(
      tester.element(find.byType(QuizScreen)),
      listen: false,
    );
    expect(find.byType(QuizScreen), findsOneWidget);
    expect(find.text('Soal 1 dari 10'), findsOneWidget);
    expect(quiz.answers[0], 1);
  });
}
