import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CollectionsPage extends ConsumerStatefulWidget {
  const CollectionsPage({super.key});

  @override
  ConsumerState createState() => _CollectionsPageState();
}

class _CollectionsPageState extends ConsumerState<CollectionsPage> {
  double leftWidth = 300;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double rightMinWidth = 100;
    final double leftMinWidth = 100;

    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: leftWidth,
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Placeholder(color: Colors.blue),
            )),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.resizeLeftRight,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragUpdate: (details) {
                setState(() {
                  leftWidth += details.delta.dx;
                  if (leftWidth < leftMinWidth) leftWidth = leftMinWidth;
                  if (leftWidth > screenWidth - rightMinWidth) {
                    leftWidth = screenWidth - rightMinWidth;
                  }
                });
              },
              child: VerticalDivider(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(child: const Placeholder(color: Colors.green)),
            ),
          ),
        ],
      ),
    );
  }
}
