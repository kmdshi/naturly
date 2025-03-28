import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:naturly/src/core/services/responsive_detection.dart';
import 'package:naturly/src/features/analysis/presentation/analysis_screen.dart';
import 'package:naturly/src/features/home/widget/home_screen.dart';
import 'package:naturly/src/features/schedule/presentation/schedule_screen.dart';
import 'package:naturly/src/features/settings/presentation/settings_screen.dart';

@RoutePage()
class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int activeIndex = 0;

  List<Widget> get pages => [
        HomeScreen(),
        ScheduleScreen(),
        AnalysisScreen(),
        SettingsScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Responsive.isMobile(context)
          ? BottomNavigationBar(
              currentIndex: activeIndex,
              items: const [
                BottomNavigationBarItem(
                  label: 'Домашняя',
                  icon: Icon(Icons.home),
                ),
                BottomNavigationBarItem(
                  label: 'Расписание',
                  icon: Icon(Icons.schedule),
                ),
                BottomNavigationBarItem(
                  label: 'Настройки',
                  icon: Icon(Icons.settings),
                ),
              ],
              onTap: (index) {
                setState(() {
                  activeIndex = index;
                });
              },
            )
          : null,
      body: !Responsive.isMobile(context)
          ? Row(
              children: [
                SideMenu(
                  builder: (data) => SideMenuData(
                    // header: const Text('Header'),
                    items: [
                      SideMenuItemDataTile(
                        isSelected: activeIndex == 0 ? true : false,
                        onTap: () {
                          if (activeIndex != 0) {
                            setState(() {
                              activeIndex = 0;
                            });
                          }
                        },
                        title: 'Домашняя',
                        icon: const Icon(Icons.home),
                      ),
                      SideMenuItemDataTile(
                        isSelected: activeIndex == 1 ? true : false,
                        onTap: () {
                          if (activeIndex != 1) {
                            setState(() {
                              activeIndex = 1;
                            });
                          }
                        },
                        title: 'Расписание',
                        icon: const Icon(Icons.home),
                      ),
                      SideMenuItemDataTile(
                        isSelected: activeIndex == 2 ? true : false,
                        onTap: () {
                          if (activeIndex != 2) {
                            setState(() {
                              activeIndex = 2;
                            });
                          }
                        },
                        title: 'Анализ',
                        icon: const Icon(Icons.home),
                      ),
                      SideMenuItemDataTile(
                        isSelected: activeIndex == 3 ? true : false,
                        onTap: () {
                          if (activeIndex != 3) {
                            setState(() {
                              activeIndex = 3;
                            });
                          }
                        },
                        title: 'Настройки',
                        icon: const Icon(Icons.home),
                      ),
                    ],
                    // footer: const Text('Footer'),
                  ),
                ),
                Expanded(
                  child: pages[activeIndex],
                ),
              ],
            )
          : pages[activeIndex],
    );
  }
}
