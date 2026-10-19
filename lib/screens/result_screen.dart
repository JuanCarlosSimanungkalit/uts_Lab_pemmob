import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/answer_review_tile.dart';
import '../widgets/app_button.dart';
import '../widgets/page_container.dart';
import '../widgets/score_card.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_screen.dart';
import 'welcome_screen.dart';

/// Halaman 3: skor akhir dan ringkasan jawaban benar/salah.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  void _retry(BuildContext context) {
    context.read<QuizProvider>().retry();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const QuizScreen()),
    );
  }

  void _backToStart(BuildContext context) {
    context.read<QuizProvider>().resetAll();
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute<void>(builder: (_) => const WelcomeScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final textTheme = Theme.of(context).textTheme;

    final scoreCard = ScoreCard(
      userName: quiz.userName,
      score: quiz.score,
      total: quiz.total,
    );

    final actions = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppButton(
          label: 'Ulangi Kuis',
          icon: Icons.replay_rounded,
          onPressed: () => _retry(context),
        ),
        SizedBox(height: context.gapS),
        AppButton(
          label: 'Kembali ke Awal',
          icon: Icons.home_outlined,
          outlined: true,
          onPressed: () => _backToStart(context),
        ),
      ],
    );

    final review = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Ringkasan Jawaban', style: textTheme.titleLarge),
        SizedBox(height: context.gapS),
        for (var i = 0; i < quiz.total; i++)
          AnswerReviewTile(
            number: i + 1,
            question: quiz.questions[i],
            selectedIndex: quiz.answers[i],
          ),
      ],
    );

    // Hasil final: tombol back sistem tidak membawa pengguna kembali ke kuis.
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Hasil Kuis'),
          actions: const [ThemeToggleButton()],
        ),
        body: PageContainer(
          child: context.useTwoColumns
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          scoreCard,
                          SizedBox(height: context.gapM),
                          actions,
                        ],
                      ),
                    ),
                    SizedBox(width: context.gapM),
                    Expanded(flex: 3, child: review),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    scoreCard,
                    SizedBox(height: context.gapM),
                    review,
                    SizedBox(height: context.gapM),
                    actions,
                  ],
                ),
        ),
      ),
    );
  }
}
