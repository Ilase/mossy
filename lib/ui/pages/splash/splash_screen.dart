import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mossys/core/routes/blure_page_route.dart';
import 'package:mossys/ui/pages/mossys/main_page.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      startLoading();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: RefreshProgressIndicator(),
      ),
    );
  }

  void startLoading() {
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).push(
        BlurPageRoute(
          builder: (context) => const MainPage(),
          settings: RouteSettings(name: 'MainPage'),
        ),
      );
    });
  }
}
