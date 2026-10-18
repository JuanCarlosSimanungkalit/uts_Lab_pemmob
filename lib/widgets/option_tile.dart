import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../utils/responsive.dart';

/// Status tampilan sebuah pilihan jawaban.
enum OptionState { normal, selected, correct, wrong }

/// Satu pilihan jawaban. Dipakai di halaman kuis (normal/selected) dan di
/// ringkasan hasil (correct/wrong).
class OptionTile extends StatelessWidget {
  const OptionTile({
    super.key,
    required this.label,
    required this.text,
    this.state = OptionState.normal,
    this.onTap,
  });

  /// Huruf pilihan (A, B, C, D).
  final String label;
  final String text;
  final OptionState state;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final quizColors = theme.extension<QuizColors>()!;
    final radius = BorderRadius.circular(context.radius);
    final badgeSize = context.wp(0.08).clamp(28.0, 40.0).toDouble();

    final style = switch (state) {
      OptionState.normal => _OptionStyle(
          background: scheme.surfaceContainerLow,
          border: scheme.outlineVariant,
          badge: scheme.surfaceContainerHighest,
          badgeText: scheme.onSurfaceVariant,
          text: scheme.onSurface,
        ),
      OptionState.selected => _OptionStyle(
          background: scheme.primaryContainer,
          border: scheme.primary,
          badge: scheme.primary,
          badgeText: scheme.onPrimary,
          text: scheme.onPrimaryContainer,
          icon: Icons.radio_button_checked,
        ),
      OptionState.correct => _OptionStyle(
          background: quizColors.correctContainer,
          border: quizColors.correct,
          badge: quizColors.correct,
          badgeText: Colors.white,
          text: scheme.onSurface,
          icon: Icons.check_circle,
        ),
      OptionState.wrong => _OptionStyle(
          background: quizColors.wrongContainer,
          border: quizColors.wrong,
          badge: quizColors.wrong,
          badgeText: Colors.white,
          text: scheme.onSurface,
          icon: Icons.cancel,
        ),
    };

    return Semantics(
      button: onTap != null,
      selected: state == OptionState.selected,
      child: Material(
        color: style.background,
        borderRadius: radius,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            padding: EdgeInsets.all(context.gapM),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: style.border,
                width: state == OptionState.normal ? 1 : 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: badgeSize,
                  height: badgeSize,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: style.badge,
                  ),
                  child: Text(
                    label,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: style.badgeText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: context.gapM),
                Expanded(
                  child: Text(
                    text,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: style.text,
                    ),
                  ),
                ),
                if (style.icon != null) ...[
                  SizedBox(width: context.gapS),
                  Icon(style.icon, color: style.border, size: context.iconSize),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionStyle {
  const _OptionStyle({
    required this.background,
    required this.border,
    required this.badge,
    required this.badgeText,
    required this.text,
    this.icon,
  });

  final Color background;
  final Color border;
  final Color badge;
  final Color badgeText;
  final Color text;
  final IconData? icon;
}
