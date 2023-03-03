import 'package:flutter/material.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({super.key, required this.onNavigate});

  final void Function(int) onNavigate;

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
            widget.onNavigate(_selectedIndex);
            Navigator.pop(context);
          });
        },
        children: <Widget>[
          DrawerHeader(
              child: Image.asset(
            'assets/logo-cpm-alpha.png',
          )),
          const NavigationDrawerDestination(icon: Icon(Icons.home_outlined), label: Text('Home')),
          const NavigationDrawerDestination(icon: Icon(Icons.people_outline), label: Text('Members')),
          const NavigationDrawerDestination(icon: Icon(Icons.map), label: Text('Locations')),
          const NavigationDrawerDestination(icon: Icon(Icons.settings), label: Text('Settings')),
          const NavigationDrawerDestination(icon: Icon(Icons.info), label: Text('Information')),
          const NavigationDrawerDestination(icon: Icon(Icons.quiz), label: Text('Test')),
        ],
      ),
    );
  }
}
