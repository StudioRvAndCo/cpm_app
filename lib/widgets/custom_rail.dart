import 'package:flutter/material.dart';

class CustomRail extends StatelessWidget {
  const CustomRail({
    super.key,
    required this.index,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
        leading: Image.asset(
          'assets/logo-cpm-alpha.png',
          width: 50,
          filterQuality: FilterQuality.high,
        ),
        labelType: NavigationRailLabelType.all,
        destinations: const <NavigationRailDestination>[
          NavigationRailDestination(icon: Icon(Icons.home_outlined), label: Text('Home')),
          NavigationRailDestination(icon: Icon(Icons.people_outline), label: Text('Members')),
          NavigationRailDestination(icon: Icon(Icons.map), label: Text('Locations')),
          NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
          NavigationRailDestination(icon: Icon(Icons.info), label: Text('Information'))
        ],
        selectedIndex: index);
  }
}
