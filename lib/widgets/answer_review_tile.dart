import 'package:flutter/material.dart';

import '../models/question.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import 'option_tile.dart';

/// Satu baris ringkasan jawaban di halaman hasil. Bisa dibuka untuk melihat
/// semua pilihan dengan penanda jawaban benar dan jawaban pengguna.
class AnswerReviewTile extends StatelessWidget {
  const AnswerReviewTile({
    super.key,
    required this.number,
    required this.question,
    required this.selectedIndex,
  });

  final int number;
  final Question question;

  /// Pilihan pengguna; `null` bila soal tidak dijawab.
  final int? selectedIndex;

  OptionState _stateFor(int index) {
    if (index == question.correctIndex) {
      return OptionState.correct;
    }
    if (index == selectedIndex) {
      return OptionState.wrong;
    }
    return OptionState.normal;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final quizColors = theme.extension<QuizColors>()!;

    final answered = selectedIndex != null;
    final isCorrect = selectedIndex == question.correctIndex;
    final color = isCorrect ? quizColors.correct : quizColors.wrong;
    final status = isCorrect
        ? 'Jawabanmu benar'
        : (answered ? 'Jawabanmu salah' : 'Tidak dijawab');

    return Padding(
      padding: EdgeInsets.only(bottom: context.gapS),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(context.radius),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: ExpansionTile(
          shape: const Border(),
          collapsedShape: const Border(),
          leading: Icon(
            isCorrect ? Icons.check_circle : Icons.cancel,
            color: color,
            size: context.iconSize,
          ),
          title: Text(
            '$number. ${question.text}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            status,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          childrenPadding: EdgeInsets.fromLTRB(
            context.gapM,
            0,
            context.gapM,
            context.gapM,
          ),
          children: [
            for (var i = 0; i < question.options.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: context.gapS),
                child: OptionTile(
                  label: String.fromCharCode(65 + i),
                  text: question.options[i],
                  state: _stateFor(i),
                ),
              ),
            if (!answered)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Kamu belum menjawab soal ini.',
                  style: theme.textTheme.bodyMedium,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
