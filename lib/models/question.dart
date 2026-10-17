/// Satu soal pilihan ganda.
class Question {
  const Question({
    required this.text,
    required this.options,
    required this.correctIndex,
  });

  /// Teks pertanyaan.
  final String text;

  /// Daftar pilihan jawaban (urutan menentukan label A, B, C, D).
  final List<String> options;

  /// Indeks pilihan yang benar di dalam [options].
  final int correctIndex;
}
