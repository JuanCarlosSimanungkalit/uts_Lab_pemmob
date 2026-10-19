import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/quiz_provider.dart';
import '../utils/responsive.dart';
import '../widgets/name_field.dart';
import '../widgets/page_container.dart';
import '../widgets/theme_toggle_button.dart';
import 'quiz_screen.dart';

/// Halaman 1: sambutan dan input nama.
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void _start(BuildContext context, String name) {
    context.read<QuizProvider>().start(name);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(builder: (_) => const QuizScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    final hero = Column(
      children: [
        Image.asset(
          'assets/images/logo.png',
          width: context.wp(0.4),
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.quiz_rounded,
            size: context.wp(0.3),
          ),
        ),
        SizedBox(height: context.gapM),
        Text(
          'FlutterQuiz',
          textAlign: TextAlign.center,
          style: textTheme.headlineLarge,
        ),
        SizedBox(height: context.gapS),
        Text(
          'Uji pemahamanmu tentang Flutter dan Dart lewat 10 soal pilihan ganda.',
          textAlign: TextAlign.center,
          style: textTheme.bodyLarge,
        ),
      ],
    );

    final form = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Masukkan namamu untuk memulai', style: textTheme.titleMedium),
        SizedBox(height: context.gapM),
        NameField(onSubmit: (name) => _start(context, name)),
      ],
    );

    return Scaffold(
      body: PageContainer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Align(
              alignment: Alignment.centerRight,
              child: ThemeToggleButton(),
            ),
            SizedBox(height: context.gapM),
            if (context.useTwoColumns)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(child: hero),
                  SizedBox(width: context.gapL),
                  Expanded(child: form),
                ],
              )
            else ...[
              hero,
              SizedBox(height: context.gapL),
              form,
            ],
          ],
        ),
      ),
    );
  }
}
