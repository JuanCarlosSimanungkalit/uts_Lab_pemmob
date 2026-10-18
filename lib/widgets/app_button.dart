import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Tombol standar aplikasi (terisi atau outline) dengan ukuran dinamis.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.outlined = false,
    this.iconAtEnd = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool outlined;

  /// Meletakkan ikon di sisi kanan teks (cocok untuk panah "berikutnya").
  final bool iconAtEnd;

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(context.radius),
    );
    final minimumSize = Size.fromHeight(context.buttonHeight);
    final textStyle = Theme.of(context).textTheme.titleMedium;
    final text = Text(label, maxLines: 1, overflow: TextOverflow.ellipsis);

    // Isi tombol: teks saja, ikon di kiri (bawaan), atau ikon di kanan.
    final Widget? endIconChild = (icon != null && iconAtEnd)
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(child: text),
              SizedBox(width: context.gapS),
              Icon(icon),
            ],
          )
        : null;

    if (outlined) {
      final style = OutlinedButton.styleFrom(
        minimumSize: minimumSize,
        shape: shape,
        textStyle: textStyle,
      );
      if (endIconChild != null || icon == null) {
        return OutlinedButton(
          onPressed: onPressed,
          style: style,
          child: endIconChild ?? text,
        );
      }
      return OutlinedButton.icon(
        onPressed: onPressed,
        style: style,
        icon: Icon(icon),
        label: text,
      );
    }

    final style = FilledButton.styleFrom(
      minimumSize: minimumSize,
      shape: shape,
      textStyle: textStyle,
    );
    if (endIconChild != null || icon == null) {
      return FilledButton(
        onPressed: onPressed,
        style: style,
        child: endIconChild ?? text,
      );
    }
    return FilledButton.icon(
      onPressed: onPressed,
      style: style,
      icon: Icon(icon),
      label: text,
    );
  }
}
