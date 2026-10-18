import 'package:flutter/material.dart';

import '../utils/responsive.dart';

/// Pembungkus isi halaman: aman dari notch, bisa di-scroll (anti-overflow),
/// dan lebarnya dibatasi agar tetap proporsional di tablet dan browser.
class PageContainer extends StatelessWidget {
  const PageContainer({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            maxWidth: AppBreakpoints.maxContentWidth,
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.all(context.gapM),
            child: child,
          ),
        ),
      ),
    );
  }
}
