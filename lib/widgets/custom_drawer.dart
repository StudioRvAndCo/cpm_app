import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int newIndex) {
          setState(() {
            _selectedIndex = newIndex;
          });
        },
        children: <Widget>[
          Image.asset(
            'assets/logo-cpm-alpha.png',
            filterQuality: FilterQuality.high,
          ),
          const NavigationDrawerDestination(icon: Icon(Icons.home_outlined), label: Text('Home')),
          const NavigationDrawerDestination(icon: Icon(Icons.people_outline), label: Text('Members')),
          const NavigationDrawerDestination(icon: Icon(Icons.map), label: Text('Locations')),
          const NavigationDrawerDestination(icon: Icon(Icons.settings), label: Text('Settings')),
          const NavigationDrawerDestination(icon: Icon(Icons.info), label: Text('Information'))
        ],
      ),
    );
  }
}
