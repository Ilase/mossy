import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mossys/core/animations/blur_transition.dart';
import 'package:mossys/core/enums/home_destinations.dart';
import 'package:mossys/ui/pages/home/home_page.dart';
import 'package:mossys/ui/pages/workspaces/workspace_page.dart';
import 'package:mossys/ui/providers/utils_providers/home_destinations_provider.dart';
import 'package:mossys/ui/widgets/workspace_button.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState createState() => _MossysState();
}

class _MossysState extends ConsumerState<MainPage> {
  final destinations = [
    HomePage(),
    WorkspacePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(homeDestinationsProvider);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.menu),
        ),
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                onPressed: () {
                  ref.read(homeDestinationsProvider.notifier).navigateToHome();
                },
                child: Text('Home'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: WorkspaceButton(),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications),
          )
        ],
      ),
      body: AnimatedSwitcher(
        duration: Duration(
          milliseconds: 200,
        ),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: BlurTransition(
              blur: animation,
              child: child,
            ),
          );
        },
        child: _navigator(pageController),
      ),
    );
  }

  Widget _navigator(HomeDestinations destination) {
    switch (destination) {
      case HomeDestinations.home:
        return HomePage();
      case HomeDestinations.workspace:
        return WorkspacePage();
      case HomeDestinations.workspaceList:
        return Placeholder();
    }
  }
}
