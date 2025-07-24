import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mossys/core/free_tab_bar/browser_tab_bar.dart';
import 'package:mossys/ui/pages/collections/collections_page.dart';
import 'package:mossys/ui/pages/environment/environment_page.dart';
import 'package:mossys/ui/pages/history/history_page.dart';

class WorkspacePage extends ConsumerStatefulWidget {
  const WorkspacePage({super.key});

  @override
  ConsumerState createState() => _WorkspacePageState();
}

class _WorkspacePageState extends ConsumerState<WorkspacePage>
    with SingleTickerProviderStateMixin {
  double leftWidth = 300;
  int _selectedIndex = 0;
  late TabController tabController;

  final destinations = [
    CollectionsPage(),
    EnvironmentPage(),
    HistoryPage(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final double rightMinWidth = 100;
    final double leftMinWidth = 100;
    return Scaffold(
      persistentFooterButtons: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.add),
        ),
      ],
      body: Row(
        children: [
          NavigationRail(
            extended: false,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
                tabController.index = _selectedIndex;
              });
            },
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.collections_bookmark),
                label: Text('Collections'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.archive),
                label: Text('Environments'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.history),
                label: Text('History'),
              ),
            ],
            selectedIndex: _selectedIndex,
          ),
          SizedBox(
            width: leftWidth,
            child: LayoutBuilder(builder: (context, constraints) {
              if (leftWidth >= 200) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Workspace'),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.add),
                                    tooltip: 'Add new item',
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.import_export),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TabBarView(
                              controller: tabController,
                              children: destinations,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
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
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth >= 200) {
                  return BrowserTabs(
                    placeholder: Center(
                      child: Text('Open request for start yo work'),
                    ),
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class AppBarMiddleActions extends StatelessWidget {
  const AppBarMiddleActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {},
          child: Text('Workspaces'),
        ),
      ],
    );
  }
}
