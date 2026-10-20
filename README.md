# FlutterQuiz

## Identitas Mahasiswa

- **Nama:** Juan Carlos Simanungkalit
- **NIM:** 241401117
- **Lab:** Pemrograman Mobile 6

## Informasi Aplikasi

**Nama aplikasi:** FlutterQuiz

**Deskripsi:** Aplikasi kuis pilihan ganda berbasis Flutter. Pengguna memasukkan
nama, menjawab 10 soal seputar Flutter dan Dart, lalu melihat skor akhir atas
nama tersebut beserta ringkasan jawaban benar dan salah.

**Fitur:**

- Input nama dengan validasi (tidak boleh kosong, minimal 2 karakter).
- 10 soal pilihan ganda (data lokal/dummy, tanpa database).
- Navigasi soal Sebelumnya/Berikutnya; jawaban yang dipilih tetap tersorot saat kembali ke soal.
- Indikator progres ("Soal n dari 10") dengan bar animasi.
- Skor akhir dengan cincin persentase, pesan sesuai nilai, dan ilustrasi.
- Ringkasan jawaban per soal (benar/salah/tidak dijawab) yang bisa dibuka untuk melihat kunci jawaban.
- Ulangi kuis (nama tetap) atau kembali ke awal (reset total).
- Konfirmasi saat keluar di tengah kuis dan saat menyelesaikan kuis dengan soal kosong.
- State management Provider: progres tidak hilang saat layar dirotasi atau berpindah halaman.
- Dual-theme (terang/gelap) dengan tombol pengganti.
- Adaptive & responsive: satu kolom di HP, dua kolom di landscape/tablet/web; semua ukuran dihitung dari lebar layar.

## Pemenuhan Kriteria Wajib

| # | Kriteria | Pemenuhan |
|---|----------|-----------|
| 1 | StatelessWidget & StatefulWidget | Hampir semua widget Stateless; `NameField` Stateful (controller dan form) |
| 2 | Min. 2 halaman + navigasi | 3 halaman (Welcome, Quiz, Result) dengan `Navigator` |
| 3 | Widget reusable di file terpisah | Folder `lib/widgets/`, satu widget per file |
| 4 | Aset gambar/ikon | `assets/images/` + Material Icons |
| 5 | Font kustom | Poppins dan Nunito (`assets/fonts/`) |
| 6 | Ukuran dinamis | `lib/utils/responsive.dart` (pecahan lebar layar, tanpa piksel tetap) |
| 7 | Progres tidak hilang | `QuizProvider` di atas `MaterialApp` |
| 8 | Tanpa database | Soal berupa list Dart lokal (`lib/data/questions.dart`) |
| 9 | GitHub per fitur | Lihat "Rencana Commit" di bawah |
| 10 | Desain bebas | Ringkasan jawaban, dual-theme, layout adaptif |

## Struktur Proyek

```
lib/
├── main.dart                  # MultiProvider + MaterialApp + tema
├── models/question.dart       # Question(text, options, correctIndex)
├── data/questions.dart        # 10 soal dummy dalam satu list
├── providers/
│   ├── quiz_provider.dart     # nama, jawaban, indeks soal, skor
│   └── theme_provider.dart    # mode terang/gelap
├── screens/
│   ├── welcome_screen.dart    # input nama
│   ├── quiz_screen.dart       # soal dan pilihan
│   └── result_screen.dart     # skor dan ringkasan jawaban
├── widgets/                   # komponen reusable (satu file per widget)
├── theme/app_theme.dart       # ColorScheme light/dark, font, warna status
└── utils/responsive.dart      # breakpoint dan helper ukuran
assets/
├── fonts/                     # Poppins dan Nunito
└── images/                    # logo, piala, buku
test/                          # unit test provider + widget test
docs/                          # spesifikasi desain
tools/generate_assets.py       # pembuat gambar aset
```

## Cara Menjalankan

Prasyarat: Flutter SDK 3.24 atau lebih baru.

```bash
# 1. Ambil dependensi dan jalankan
flutter pub get
flutter run

```

## Dokumentasi

### Credit Aset

- **Font Poppins** dan **Nunito** - Google Fonts, lisensi SIL Open Font License 1.1.
- **Gambar** (`logo.png`, `trophy.png`, `book.png`) - dibuat sendiri secara programatik
  dengan skrip `tools/generate_assets.py` (Python + Pillow), tanpa sumber eksternal.
- **Ikon** - Material Icons bawaan Flutter (Apache License 2.0).
