import 'dart:ui';

import 'package:flutter/material.dart';

class BlurPageRoute<T> extends PageRoute<T> {
  final WidgetBuilder builder;
  @override
  final RouteSettings settings;

  BlurPageRoute({
    required this.builder,
    this.transitionDuration = const Duration(milliseconds: 1000),
    required this.settings,
  });

  @override
  final Duration transitionDuration;

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => Colors.transparent;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final child = builder(context);

    return FadeTransition(
      opacity: animation,
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0 * animation.value,
              sigmaY: 10.0 * animation.value,
            ),
            child: Container(
              color: Colors.black.withOpacity(0.2 * animation.value),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
