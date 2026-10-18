import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Kartu skor akhir: ilustrasi, sapaan, cincin persentase, dan pesan.
class ScoreCard extends StatelessWidget {
  const ScoreCard({
    super.key,
    required this.userName,
    required this.score,
    required this.total,
  });

  final String userName;
  final int score;
  final int total;

  double get _ratio => total == 0 ? 0 : score / total;

  String get _message {
    if (_ratio >= 0.8) {
      return 'Luar biasa! Pemahaman Flutter-mu sangat baik.';
    }
    if (_ratio >= 0.6) {
      return 'Bagus! Sedikit lagi menuju sempurna.';
    }
    if (_ratio >= 0.4) {
      return 'Lumayan. Terus belajar, kamu pasti bisa!';
    }
    return 'Jangan menyerah. Coba ulangi kuisnya!';
  }

  String get _image =>
      _ratio >= 0.6 ? 'assets/images/trophy.png' : 'assets/images/book.png';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final ringSize = context.wp(0.4);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.gapM * 1.5),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(context.radius),
      ),
      child: Column(
        children: [
          Image.asset(
            _image,
            height: context.wp(0.3),
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.emoji_events_rounded,
              size: context.wp(0.25),
              color: scheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: context.gapM),
          Text(
            'Halo, $userName!',
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: scheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: context.gapM),
          SizedBox(
            width: ringSize,
            height: ringSize,
            child: TweenAnimationBuilder<double>(
              tween: Tween<double>(end: _ratio),
              duration: const Duration(milliseconds: 800),
              curve: Curves.easeOutCubic,
              builder: (context, value, _) => Stack(
                fit: StackFit.expand,
                children: [
                  CircularProgressIndicator(
                    value: value,
                    strokeWidth: context.wp(0.03),
                    backgroundColor: scheme.surface,
                  ),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$score/$total',
                          style: theme.textTheme.headlineMedium?.copyWith(
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                        Text(
                          '${(_ratio * 100).round()}%',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.gapM),
          Text(
            '$score benar, ${total - score} salah',
            style: theme.textTheme.titleMedium?.copyWith(
              color: scheme.onPrimaryContainer,
            ),
          ),
          SizedBox(height: context.gapS),
          Text(
            _message,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: scheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
