import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Kartu yang menampilkan teks pertanyaan.
class QuestionCard extends StatelessWidget {
  const QuestionCard({super.key, required this.number, required this.text});

  final int number;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.gapM * 1.5),
      decoration: BoxDecoration(
        color: scheme.primaryContainer,
        borderRadius: BorderRadius.circular(context.radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.help_outline_rounded,
                size: context.iconSize,
                color: scheme.onPrimaryContainer,
              ),
              SizedBox(width: context.gapS),
              Text(
                'Pertanyaan $number',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: scheme.onPrimaryContainer,
                ),
              ),
            ],
          ),
          SizedBox(height: context.gapM),
          Text(
            text,
            style: theme.textTheme.titleLarge?.copyWith(
              color: scheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
