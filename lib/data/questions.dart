import '../models/question.dart';

/// Data soal dummy (lokal, tanpa database).
/// Seluruh soal berada dalam satu list agar struktur proyek tetap ringkas.
const List<Question> quizQuestions = [
  Question(
    text: 'Bahasa pemrograman apa yang digunakan untuk membangun aplikasi Flutter?',
    options: ['Kotlin', 'Dart', 'Swift', 'JavaScript'],
    correctIndex: 1,
  ),
  Question(
    text: 'Widget manakah yang tidak memiliki state internal yang dapat berubah?',
    options: ['StatefulWidget', 'InheritedWidget', 'StatelessWidget', 'AnimatedWidget'],
    correctIndex: 2,
  ),
  Question(
    text: 'Method apa yang dipanggil di dalam State untuk memberi tahu Flutter bahwa tampilan perlu dibangun ulang?',
    options: ['rebuild()', 'refresh()', 'update()', 'setState()'],
    correctIndex: 3,
  ),
  Question(
    text: 'Widget apa yang menyusun anak-anaknya secara vertikal?',
    options: ['Column', 'Row', 'Stack', 'Container'],
    correctIndex: 0,
  ),
  Question(
    text: 'File apa yang dipakai untuk mendaftarkan dependensi, aset, dan font di proyek Flutter?',
    options: ['main.dart', 'pubspec.yaml', 'AndroidManifest.xml', 'analysis_options.yaml'],
    correctIndex: 1,
  ),
  Question(
    text: 'Widget apa yang menumpuk anak-anaknya satu di atas yang lain?',
    options: ['Column', 'ListView', 'Stack', 'Expanded'],
    correctIndex: 2,
  ),
  Question(
    text: 'Perintah apa yang digunakan untuk menjalankan aplikasi Flutter dari terminal?',
    options: ['flutter build', 'flutter start', 'flutter create', 'flutter run'],
    correctIndex: 3,
  ),
  Question(
    text: 'Class apa yang dipakai untuk berpindah antar-halaman dengan push dan pop?',
    options: ['Scaffold', 'Navigator', 'MediaQuery', 'Theme'],
    correctIndex: 1,
  ),
  Question(
    text: 'Fitur apa yang menampilkan perubahan kode ke aplikasi yang sedang berjalan tanpa menghilangkan state saat ini?',
    options: ['Hot Reload', 'Hot Restart', 'Clean Build', 'Cold Boot'],
    correctIndex: 0,
  ),
  Question(
    text: 'Widget apa yang paling tepat untuk daftar panjang dengan item yang dibangun hanya saat dibutuhkan?',
    options: ['Column', 'Row', 'Stack', 'ListView.builder'],
    correctIndex: 3,
  ),
];
