import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/common/router/router.gr.dart';
import 'package:naturly/src/core/widget/side_drawer.dart';

@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [HomeRoute(), ScheduleRoute(), AnalysisRoute(), SettingsRoute()],
      builder: (context, tabsRouter) {
        return Row(children: [SideDrawer(), Expanded(child: tabsRouter)]);
      },
    );
  }
}
