import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TabData {
  String title;
  final IconData icon;
  Widget content;

  TabData({required this.title, required this.icon, required this.content});

  TabData copy() => TabData(title: title, icon: icon, content: content);
}

class BrowserTabs extends StatefulWidget {
  const BrowserTabs({super.key, required this.placeholder});

  final Widget placeholder;

  @override
  State<BrowserTabs> createState() => _BrowserTabsState();
}

class _BrowserTabsState extends State<BrowserTabs> {
  final List<TabData> tabs = [];
  int? selectedIndex;
  OverlayEntry? _contextMenu;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (kIsWeb) {
      // ignore: undefined_prefixed_name
      BrowserContextMenu.disableContextMenu();
    }
  }

  void _addTab() {
    setState(() {
      tabs.add(TabData(
          title: 'Tab ${tabs.length + 1}',
          icon: Icons.insert_drive_file,
          content: Center(
            child: Text('Content of this tab'),
          )));
      selectedIndex = tabs.length - 1;
    });
  }

  void _removeTab(int index) {
    setState(() {
      tabs.removeAt(index);
      if (tabs.isEmpty) {
        selectedIndex = null;
      } else {
        selectedIndex = min(selectedIndex ?? 0, tabs.length - 1);
      }
    });
  }

  void _renameTabDialog(int index) async {
    final controller = TextEditingController(text: tabs[index].title);
    final newTitle = await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rename Tab'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Tab name'),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () => Navigator.pop(context, controller.text.trim()),
                child: const Text('OK')),
          ],
        );
      },
    );
    if (newTitle != null && newTitle.isNotEmpty) {
      setState(() {
        tabs[index].title = newTitle;
      });
    }
  }

  void _removeContextMenu() {
    _contextMenu?.remove();
    _contextMenu = null;
  }

  void _showContextMenu(BuildContext context, Offset position, int tabIndex) {
    _removeContextMenu();

    final overlay = Overlay.of(context);

    _contextMenu = OverlayEntry(
      builder: (ctx) => Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: _removeContextMenu,
              behavior: HitTestBehavior.translucent,
            ),
          ),
          Positioned(
            left: position.dx,
            top: position.dy,
            child: Material(
              elevation: 1,
              borderRadius: BorderRadius.circular(16),
              child: IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () {
                        _removeTab(tabIndex);
                        _removeContextMenu();
                      },
                      child: const Text('Close Tab'),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          tabs.insert(tabIndex + 1, tabs[tabIndex].copy());
                        });
                        _removeContextMenu();
                      },
                      child: const Text('Duplicate Tab'),
                    ),
                    TextButton(
                      onPressed: () {
                        _removeContextMenu();
                        _renameTabDialog(tabIndex);
                      },
                      child: const Text('Rename Tab'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    overlay.insert(_contextMenu!);
  }

  Widget _buildTab(int index, TabData tab) {
    final isSelected = selectedIndex == index;

    return Listener(
      onPointerDown: (event) {
        if (event.kind == PointerDeviceKind.mouse &&
            event.buttons == kSecondaryMouseButton) {
          _showContextMenu(context, event.position, index);
        }
      },
      child: Tooltip(
        message: tab.title,
        waitDuration: const Duration(milliseconds: 300),
        child: GestureDetector(
          onTap: () {
            final isShiftPressed = HardwareKeyboard.instance.isShiftPressed;

            if (isShiftPressed) {
              _removeTab(index);
            } else {
              setState(() => selectedIndex = index);
            }
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[100] : Colors.grey[200],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(tab.icon, size: 16),
                const SizedBox(width: 6),
                Text(
                  tab.title,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(width: 4),
                InkWell(
                  onTap: () => _removeTab(index),
                  child: const Icon(Icons.close, size: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Listener(
      onPointerSignal: (event) {
        if (event is PointerScrollEvent) {
          _scrollController.jumpTo(
            _scrollController.offset + event.scrollDelta.dy,
          );
        }
      },
      child: Row(
        children: [
          IconButton(
            onPressed: _addTab,
            icon: const Icon(Icons.add),
            tooltip: 'New Tab',
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _scrollController,
              child: Row(
                children: List.generate(tabs.length, (index) {
                  return _buildTab(index, tabs[index]);
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTabBar(),
        const Divider(height: 1),
        Expanded(
          child: Builder(builder: (context) {
            if (selectedIndex != null) {
              return tabs[selectedIndex!].content;
            } else {
              return widget.placeholder;
            }
          }),
        ),
        // Expanded(
        //   child: tabs.isEmpty
        //       ? const Center(child: Text('No content'))
        //       : Center(
        //           child: Text(
        //             'Content: ${tabs[selectedIndex!].title}',
        //             style: Theme.of(context).textTheme.headlineSmall,
        //           ),
        //         ),
        // )
      ],
    );
  }

  @override
  void dispose() {
    _removeContextMenu();
    _scrollController.dispose();
    super.dispose();
  }
}
