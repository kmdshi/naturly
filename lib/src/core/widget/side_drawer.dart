import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({super.key});

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    final tabsRouter = AutoTabsRouter.of(context);
    return SideMenu(
      mode: SideMenuMode.compact,
      hasResizer: false,
      hasResizerToggle: false,
      builder:
          (data) => SideMenuData(
            items: [
              SideMenuItemDataTile(
                title: 'Домашняя',
                icon: const Icon(Icons.home),
                isSelected: tabsRouter.activeIndex == 0 ? true : false,
                onTap:
                    () => setState(() {
                      tabsRouter.setActiveIndex(0);
                    }),
              ),
              SideMenuItemDataTile(
                title: 'Расписание',
                icon: const Icon(Icons.home),
                isSelected: tabsRouter.activeIndex == 1 ? true : false,
                onTap:
                    () => setState(() {
                      tabsRouter.setActiveIndex(1);
                    }),
              ),
              SideMenuItemDataTile(
                title: 'Анализ',
                icon: const Icon(Icons.home),
                isSelected: tabsRouter.activeIndex == 2 ? true : false,
                onTap:
                    () => setState(() {
                      tabsRouter.setActiveIndex(2);
                    }),
              ),
              SideMenuItemDataTile(
                title: 'Настройки',
                icon: const Icon(Icons.home),
                isSelected: tabsRouter.activeIndex == 3 ? true : false,
                onTap:
                    () => setState(() {
                      tabsRouter.setActiveIndex(3);
                    }),
              ),
            ],
            // footer: const Text('Footer'),
          ),
    );
  }
}
