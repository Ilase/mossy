import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mossys/core/enums/home_destinations.dart';

class HomeDestinationsNotifier extends StateNotifier<HomeDestinations> {
  HomeDestinationsNotifier() : super(HomeDestinations.home);

  void navigateToHome() {
    state = HomeDestinations.home;
  }

  void navigateToWorkspaces() {
    state = HomeDestinations.workspace;
  }

  void navigateToWorkspaceList() {
    state = HomeDestinations.workspaceList;
  }
}

final homeDestinationsProvider =
    StateNotifierProvider<HomeDestinationsNotifier, HomeDestinations>((ref) {
  return HomeDestinationsNotifier();
});
