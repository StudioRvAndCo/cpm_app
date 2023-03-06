import 'package:easy_localization/easy_localization.dart';
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
          NavigationDrawerDestination(
              icon: const Icon(Icons.home_outlined), label: Text('home'.tr())),
          NavigationDrawerDestination(
              icon: const Icon(Icons.people_outline),
              label: Text('members.member.upper'.plural(2))),
          NavigationDrawerDestination(
              icon: const Icon(Icons.map),
              label: Text('locations.location.upper'.plural(2))),
          NavigationDrawerDestination(
              icon: const Icon(Icons.settings), label: Text('settings'.tr())),
          NavigationDrawerDestination(
              icon: const Icon(Icons.info), label: Text('information'.tr())),
          const NavigationDrawerDestination(
              icon: Icon(Icons.quiz), label: Text('Test')),
        ],
      ),
    );
  }
}
