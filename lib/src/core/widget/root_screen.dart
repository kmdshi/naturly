import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/common/layout/layout.dart';
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
      builder: (context, tb) {
        final tabsRouter = AutoTabsRouter.of(context);

        return WindowSizeScope.of(context).isCompact ||
                WindowSizeScope.of(context).isMedium
            ? Scaffold(
              body: tb,
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: tabsRouter.activeIndex,
                onTap: tabsRouter.setActiveIndex,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.white,
                selectedItemColor: Color(0xFF5932EA),
                unselectedItemColor: Colors.black54,
                selectedFontSize: 12,
                unselectedFontSize: 12,
                showUnselectedLabels: true,
                items: [
                  BottomNavigationBarItem(
                    icon: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/home.png',
                        width: 26,
                        height: 26,
                        color: Colors.black54,
                      ),
                    ),
                    activeIcon: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/home.png',
                        width: 26,
                        height: 26,
                        color: Color(0xFF5932EA),
                      ),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/calendar.png',
                        width: 26,
                        height: 26,
                        color: Colors.black54,
                      ),
                    ),
                    activeIcon: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/calendar.png',
                        width: 26,
                        height: 26,
                        color: Color(0xFF5932EA),
                      ),
                    ),
                    label: 'Schedule',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/analysis.png',
                        width: 26,
                        height: 26,
                        color: Colors.black54,
                      ),
                    ),
                    activeIcon: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/analysis.png',
                        width: 26,
                        height: 26,
                        color: Color(0xFF5932EA),
                      ),
                    ),
                    label: 'Analysis',
                  ),
                  BottomNavigationBarItem(
                    icon: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/settings.png',
                        width: 26,
                        height: 26,
                        color: Colors.black54,
                      ),
                    ),
                    activeIcon: Container(
                      height: 48,
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/icons/settings.png',
                        width: 26,
                        height: 26,
                        color: Color(0xFF5932EA),
                      ),
                    ),
                    label: 'Settings',
                  ),
                ],
              ),
            )
            : Row(children: [SideDrawer(), Expanded(child: tb)]);
      },
    );
  }
}
