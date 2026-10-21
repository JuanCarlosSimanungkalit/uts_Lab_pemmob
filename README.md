# FlutterQuiz

Aplikasi kuis pilihan ganda tentang Flutter dan Dart, dibuat untuk UTS Praktikum Pemrograman Mobile.

## Identitas Mahasiswa

| | |
|---|---|
| **Nama** | Juan Carlos Simanungkalit |
| **NIM** | 241401117 |
| **Lab** | Pemrograman Mobile 6 |

## Informasi Aplikasi

### Nama Aplikasi

FlutterQuiz

### Deskripsi Singkat

FlutterQuiz meminta pengguna mengisi nama, menjawab 10 soal pilihan ganda seputar Flutter dan Dart, lalu menampilkan skor akhir atas nama pengguna beserta pembahasan tiap soal. Seluruh soal tersimpan di dalam kode, tanpa database.

### Fitur

- Input nama dengan validasi: tidak boleh kosong dan minimal 2 karakter.
- 10 soal pilihan ganda dengan 4 opsi per soal.
- Tombol Sebelumnya dan Berikutnya. Jawaban yang sudah dipilih tetap tersorot saat pengguna kembali ke soal itu.
- Indikator progres "Soal n dari 10" dengan bar animasi.
- Halaman hasil dengan skor, persentase, dan pesan sesuai nilai.
- Ringkasan jawaban per soal: benar, salah, atau tidak dijawab. Setiap soal bisa dibuka untuk melihat kunci jawabannya.
- Ulangi Kuis dengan nama yang sama, atau Kembali ke Awal untuk mengisi nama baru.
- Dialog konfirmasi saat pengguna keluar di tengah kuis dan saat menyelesaikan kuis dengan soal yang belum dijawab.
- Progres kuis tetap tersimpan saat layar dirotasi atau pengguna berpindah halaman (state management Provider).
- Mode terang dan gelap, dengan tombol pengganti di setiap halaman.
- Tampilan responsif: satu kolom di HP, dua kolom di layar lebar seperti HP landscape, tablet, dan web.

## Dokumentasi

### Credit Aset

| Aset | Sumber | Lisensi |
|---|---|---|
| Font Poppins | [Google Fonts](https://fonts.google.com/specimen/Poppins) | SIL Open Font License 1.1 |
| Font Nunito | [Google Fonts](https://fonts.google.com/specimen/Nunito) | SIL Open Font License 1.1 |
| Ikon | Material Icons bawaan Flutter | Apache License 2.0 |
| Gambar `logo.png`, `trophy.png`, `book.png` | Dibuat sendiri dengan skrip `tools/generate_assets.py` (Python dan Pillow) | Milik pembuat |
| Paket [`provider`](https://pub.dev/packages/provider) | pub.dev | MIT |


### Mockup / Prototype

https://www.figma.com/design/ozK1oRGMamEuHvCgPm5qCX/FlutterQuiz-Mockup?node-id=2-230&t=aiHTuYCl3bDJANFz-1

## Struktur Proyek

```
lib/
├── main.dart                  # MultiProvider, MaterialApp, tema
├── models/question.dart       # model soal
├── data/questions.dart        # 10 soal dalam satu list
├── providers/
│   ├── quiz_provider.dart     # nama, jawaban, indeks soal, skor
│   └── theme_provider.dart    # mode terang dan gelap
├── screens/
│   ├── welcome_screen.dart    # input nama
│   ├── quiz_screen.dart       # soal dan pilihan jawaban
│   └── result_screen.dart     # skor dan ringkasan jawaban
├── widgets/                   # widget reusable, satu file per widget
├── theme/app_theme.dart       # warna, font, tema terang dan gelap
└── utils/responsive.dart      # breakpoint dan helper ukuran
assets/
├── fonts/                     # Poppins dan Nunito
└── images/                    # logo, piala, buku
test/                          # unit test provider dan widget test
```

## Cara Menjalankan

Prasyarat: Flutter SDK.

```bash
flutter pub get
flutter run
```

Untuk menjalankan di browser:

```bash
flutter run -d chrome
```
