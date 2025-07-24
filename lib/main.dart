import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mossys/ui/pages/splash/splash_screen.dart';

void main() {
  runApp(ProviderScope(child: const Mossys()));
}

class Mossys extends StatelessWidget {
  const Mossys({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreen());
  }
}
