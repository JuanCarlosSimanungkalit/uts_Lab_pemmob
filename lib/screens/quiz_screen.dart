import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/app_button.dart';
import '../widgets/confirm_dialog.dart';
import '../widgets/option_tile.dart';
import '../widgets/page_container.dart';
import '../widgets/progress_header.dart';
import '../widgets/question_card.dart';
import '../widgets/theme_toggle_button.dart';
import 'result_screen.dart';
import 'welcome_screen.dart';

/// Halaman 2: menjawab soal satu per satu.
///
/// Semua state (soal aktif dan jawaban) ada di [QuizProvider], jadi layar ini
/// cukup StatelessWidget dan aman dari rotasi.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  Future<void> _confirmExit(BuildContext context) async {
    final quiz = context.read<QuizProvider>();
    final navigator = Navigator.of(context);
    final leave = await showConfirmDialog(
      context,
      title: 'Keluar dari kuis?',
      message: 'Progres jawabanmu akan dihapus.',
      confirmLabel: 'Keluar',
      cancelLabel: 'Lanjut kuis',
    );
    if (!leave) {
      return;
    }
    quiz.resetAll();
    navigator.pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const WelcomeScreen()),
    );
  }

  Future<void> _finish(BuildContext context) async {
    final quiz = context.read<QuizProvider>();
    final navigator = Navigator.of(context);
    if (quiz.hasUnanswered) {
      final proceed = await showConfirmDialog(
        context,
        title: 'Selesaikan kuis?',
        message:
            'Masih ada ${quiz.unansweredCount} soal yang belum dijawab dan akan dihitung salah.',
        confirmLabel: 'Selesai',
        cancelLabel: 'Kembali',
      );
      if (!proceed) {
        return;
      }
    }
    navigator.pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const ResultScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final question = quiz.currentQuestion;

    final header = ProgressHeader(
      current: quiz.currentIndex + 1,
      total: quiz.total,
      userName: quiz.userName,
    );

    final questionCard = QuestionCard(
      number: quiz.currentIndex + 1,
      text: question.text,
    );

    final options = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (var i = 0; i < question.options.length; i++)
          Padding(
            padding: EdgeInsets.only(bottom: context.gapS),
            child: OptionTile(
              label: String.fromCharCode(65 + i),
              text: question.options[i],
              state: quiz.selectedAnswer == i
                  ? OptionState.selected
                  : OptionState.normal,
              onTap: () => quiz.selectAnswer(i),
            ),
          ),
      ],
    );

    final navigation = Row(
      children: [
        Expanded(
          child: AppButton(
            label: 'Sebelumnya',
            icon: Icons.arrow_back,
            outlined: true,
            onPressed: quiz.isFirstQuestion ? null : quiz.previous,
          ),
        ),
        SizedBox(width: context.gapM),
        Expanded(
          child: quiz.isLastQuestion
              ? AppButton(
                  label: 'Selesai',
                  icon: Icons.flag_rounded,
                  onPressed: () => _finish(context),
                )
              : AppButton(
                  label: 'Berikutnya',
                  icon: Icons.arrow_forward,
                  iconAtEnd: true,
                  onPressed: quiz.next,
                ),
        ),
      ],
    );

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _confirmExit(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            tooltip: 'Keluar',
            icon: const Icon(Icons.close),
            onPressed: () => _confirmExit(context),
          ),
          title: const Text('Kuis Flutter'),
          actions: const [ThemeToggleButton()],
        ),
        body: PageContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              header,
              SizedBox(height: context.gapM),
              if (context.useTwoColumns)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: questionCard),
                    SizedBox(width: context.gapM),
                    Expanded(child: options),
                  ],
                )
              else ...[
                questionCard,
                SizedBox(height: context.gapM),
                options,
              ],
              SizedBox(height: context.gapM),
              navigation,
            ],
          ),
        ),
      ),
    );
  }
}
