import 'dart:ui';

import 'package:flutter/material.dart';

class BlurTransition extends StatelessWidget {
  final Widget child;
  final Animation<double> blur;

  const BlurTransition({super.key, required this.child, required this.blur});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: blur,
      builder: (context, child) {
        return ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: blur.value * 10,
              sigmaY: blur.value * 10,
            ),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
