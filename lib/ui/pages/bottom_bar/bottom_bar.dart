import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const BottomBar({super.key});

  @override
  ConsumerState createState() => _BottomBarState();

  @override
  Size get preferredSize => Size.fromHeight(56);
}

class _BottomBarState extends ConsumerState<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
      ),
      child: Row(
        children: [
          Text('data'),
          Text('data'),
          Text('data'),
          Text('data'),
        ],
      ),
    );
  }
}
