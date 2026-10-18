import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/providers/quiz_provider.dart';

void main() {
  group('QuizProvider', () {
    late QuizProvider quiz;

    setUp(() {
      quiz = QuizProvider()..start('  Budi  ');
    });

    test('start menyimpan nama yang dipangkas dan mulai dari soal pertama', () {
      expect(quiz.userName, 'Budi');
      expect(quiz.currentIndex, 0);
      expect(quiz.answeredCount, 0);
    });

    test('semua jawaban benar menghasilkan skor penuh', () {
      for (var i = 0; i < quiz.total; i++) {
        quiz.selectAnswer(quizQuestions[i].correctIndex);
        if (!quiz.isLastQuestion) {
          quiz.next();
        }
      }
      expect(quiz.score, quiz.total);
      expect(quiz.hasUnanswered, isFalse);
    });

    test('jawaban salah tidak menambah skor', () {
      final wrong = (quizQuestions[0].correctIndex + 1) % 4;
      quiz.selectAnswer(wrong);
      expect(quiz.score, 0);
      expect(quiz.answeredCount, 1);
    });

    test('soal yang tidak dijawab dihitung salah', () {
      quiz.selectAnswer(quizQuestions[0].correctIndex);
      expect(quiz.score, 1);
      expect(quiz.unansweredCount, quiz.total - 1);
      expect(quiz.hasUnanswered, isTrue);
    });

    test('next dan previous tidak melewati batas', () {
      quiz.previous();
      expect(quiz.currentIndex, 0);

      for (var i = 0; i < quiz.total + 3; i++) {
        quiz.next();
      }
      expect(quiz.currentIndex, quiz.total - 1);
      expect(quiz.isLastQuestion, isTrue);
    });

    test('jawaban bertahan setelah berpindah soal', () {
      quiz.selectAnswer(2);
      quiz.next();
      quiz.previous();
      expect(quiz.selectedAnswer, 2);
    });

    test('selectAnswer mengabaikan indeks di luar rentang', () {
      quiz.selectAnswer(99);
      quiz.selectAnswer(-1);
      expect(quiz.selectedAnswer, isNull);
    });

    test('retry menghapus progres tetapi mempertahankan nama', () {
      quiz.selectAnswer(1);
      quiz.next();
      quiz.retry();
      expect(quiz.userName, 'Budi');
      expect(quiz.currentIndex, 0);
      expect(quiz.answeredCount, 0);
    });

    test('resetAll menghapus nama dan progres', () {
      quiz.selectAnswer(1);
      quiz.resetAll();
      expect(quiz.userName, isEmpty);
      expect(quiz.answeredCount, 0);
      expect(quiz.currentIndex, 0);
    });
  });
}
