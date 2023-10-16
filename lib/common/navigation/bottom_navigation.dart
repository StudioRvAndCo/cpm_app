import 'dart:io';

import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation();

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int? index) {
    if (index != null) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          context.goNamed(RouterRoute.projects.name);
        case 1:
          context.goNamed(RouterRoute.members.name);
        case 2:
          context.goNamed(RouterRoute.locations.name);
        case 3:
          context.goNamed(RouterRoute.settings.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? NavigationBar(
            surfaceTintColor: Theme.of(context).colorScheme.primary,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.movie_outlined),
                selectedIcon: const Icon(Icons.movie),
                label: localizations.navigation_projects,
              ),
              NavigationDestination(
                icon: const Icon(Icons.group_outlined),
                selectedIcon: const Icon(Icons.group),
                label: localizations.navigation_members,
              ),
              NavigationDestination(
                icon: const Icon(Icons.map_outlined),
                selectedIcon: const Icon(Icons.map),
                label: localizations.navigation_locations,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: localizations.navigation_settings,
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
          )
        : CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.film),
                activeIcon: const Icon(CupertinoIcons.film_fill),
                label: localizations.navigation_projects,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.group),
                activeIcon: const Icon(CupertinoIcons.group_solid),
                label: localizations.navigation_members,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.map),
                activeIcon: const Icon(CupertinoIcons.map_fill),
                label: localizations.navigation_locations,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.settings),
                activeIcon: const Icon(CupertinoIcons.settings_solid),
                label: localizations.navigation_settings,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onDestinationSelected,
          );
  }
}
