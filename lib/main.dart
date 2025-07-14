import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mossys/ui/pages/workspace_page.dart';

void main() {
  runApp(ProviderScope(child: const Mossys()));
}

class Mossys extends StatelessWidget {
  const Mossys({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: WorkspacePage());
  }
}
