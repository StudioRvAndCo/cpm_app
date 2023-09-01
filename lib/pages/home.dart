import 'package:cpm/utils/platform_identifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/navigation/navigation.dart';
import '../utils/constants_globals.dart';
import '../widgets/navigation/custom_appbar.dart';
import '../widgets/navigation/custom_navigation_drawer.dart';
import '../widgets/navigation/custom_navigation_rail.dart';
import 'about.dart';
import 'locations.dart';
import 'members.dart';
import 'projects.dart';
import 'settings.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends ConsumerState<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PlatformIdentifier().isNotComputer() ? const CustomAppBar() : null,
      body: SafeArea(
        child: Row(children: <Widget>[
          if (PlatformIdentifier().isComputer()) CustomNavigationRail(navigate: (int index) => navigate(index)),
          getPage(),
        ]),
      ),
      drawer: PlatformIdentifier().isNotComputer()
          ? CustomNavigationDrawer(navigate: (int index) => navigate(index), selectedIndex: _selectedIndex)
          : null,
    );
  }

  void navigate(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget getPage() {
    switch (_selectedIndex) {
      case 0:
        Future<void>(() => ref.read(navigationProvider.notifier).set(HomePage.projects));
        return Projects(key: projectsStateKey);
      case 1:
        return const Members();
      case 2:
        return const Locations();
      case 3:
        return const Settings();
      case 4:
        return const About();
      default:
        return const About();
    }
  }
}
