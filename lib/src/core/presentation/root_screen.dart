import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naturly/src/core/services/responsive_detection.dart';
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
        SettingsScreen(),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: !Responsive.isMobile(context)
          ? Drawer(
              child: ListView(
                children: <Widget>[
                  const DrawerHeader(
                    child: Text('Menu'),
                    decoration: BoxDecoration(color: Colors.blue),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home),
                    title: const Text('Домашняя'),
                    onTap: () {
                      if (activeIndex != 0) {
                        setState(() {
                          activeIndex = 0;
                        });
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.list),
                    title: Text('Расписание'),
                    onTap: () {
                      if (activeIndex != 1) {
                        setState(() {
                          activeIndex = 1;
                        });
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                  ListTile(
                    title: Text('Настройки'),
                    leading: Icon(Icons.graphic_eq),
                    onTap: () {
                      if (activeIndex != 2) {
                        setState(() {
                          activeIndex = 2;
                        });
                      }
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            )
          : null,
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
      body: pages[activeIndex],
    );
  }
}
