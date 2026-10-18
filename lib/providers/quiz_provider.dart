import 'package:flutter/foundation.dart';

import '../data/questions.dart';
import '../models/question.dart';

/// Satu-satunya sumber kebenaran untuk progres kuis.
///
/// Provider ini diletakkan di atas `MaterialApp`, sehingga nama, jawaban, dan
/// posisi soal tidak hilang ketika layar dirotasi atau pengguna berpindah
/// halaman.
class QuizProvider extends ChangeNotifier {
  QuizProvider({List<Question> questions = quizQuestions})
      : _questions = questions,
        _answers = List<int?>.filled(questions.length, null);

  final List<Question> _questions;

  /// Jawaban pengguna per soal; `null` berarti belum dijawab.
  final List<int?> _answers;

  String _userName = '';
  int _currentIndex = 0;

  // --- State yang dibaca UI -------------------------------------------------

  String get userName => _userName;
  List<Question> get questions => List.unmodifiable(_questions);
  List<int?> get answers => List.unmodifiable(_answers);
  int get total => _questions.length;
  int get currentIndex => _currentIndex;
  Question get currentQuestion => _questions[_currentIndex];
  int? get selectedAnswer => _answers[_currentIndex];

  bool get isFirstQuestion => _currentIndex == 0;
  bool get isLastQuestion => _currentIndex == total - 1;

  int get answeredCount => _answers.where((answer) => answer != null).length;
  int get unansweredCount => total - answeredCount;
  bool get hasUnanswered => unansweredCount > 0;

  /// Jumlah jawaban benar. Soal yang tidak dijawab dihitung salah.
  int get score {
    var correct = 0;
    for (var i = 0; i < total; i++) {
      if (_answers[i] == _questions[i].correctIndex) {
        correct++;
      }
    }
    return correct;
  }

  // --- Aksi -----------------------------------------------------------------

  /// Memulai kuis baru atas nama [name].
  void start(String name) {
    _userName = name.trim();
    _clearProgress();
    notifyListeners();
  }

  /// Menyimpan jawaban untuk soal yang sedang tampil.
  void selectAnswer(int optionIndex) {
    if (optionIndex < 0 || optionIndex >= currentQuestion.options.length) {
      return;
    }
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void next() {
    if (isLastQuestion) {
      return;
    }
    _currentIndex++;
    notifyListeners();
  }

  void previous() {
    if (isFirstQuestion) {
      return;
    }
    _currentIndex--;
    notifyListeners();
  }

  /// Mengulang kuis dengan nama yang sama.
  void retry() {
    _clearProgress();
    notifyListeners();
  }

  /// Menghapus semuanya, termasuk nama.
  void resetAll() {
    _userName = '';
    _clearProgress();
    notifyListeners();
  }

  void _clearProgress() {
    _currentIndex = 0;
    for (var i = 0; i < _answers.length; i++) {
      _answers[i] = null;
    }
  }
}
