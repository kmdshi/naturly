import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/common/layout/layout.dart';
import 'package:naturly/src/feature/home/widget/home_screen_desktop.dart';
import 'package:naturly/src/feature/home/widget/home_screen_mobile.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child:
            WindowSizeScope.of(context).isCompact ||
                    WindowSizeScope.of(context).isMedium
                ? HomeScreenMobile()
                : HomeScreenDesktop(),
      ),
    );
  }
}
