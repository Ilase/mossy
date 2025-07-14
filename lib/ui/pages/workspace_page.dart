import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mossys/ui/pages/collections/collections_page.dart';

class WorkspacePage extends ConsumerStatefulWidget {
  const WorkspacePage({super.key});

  @override
  ConsumerState createState() => _WorkspacePageState();
}

class _WorkspacePageState extends ConsumerState<WorkspacePage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController tabController;

  final destinations = [
    CollectionsPage(),
    Placeholder(),
    Placeholder(),
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          )
        ],
      ),
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
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: destinations,
            ),
          ),
        ],
      ),
    );
  }
}
