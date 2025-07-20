import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryPage extends ConsumerStatefulWidget {
  const HistoryPage({super.key});

  @override
  ConsumerState createState() => _HistoryPageState();
}

class _HistoryPageState extends ConsumerState<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('History page'),
    );
  }
}
