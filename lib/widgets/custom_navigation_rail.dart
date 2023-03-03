import 'package:flutter/material.dart';

import '../main.dart';

class CustomNavigationRail extends StatefulWidget {
  const CustomNavigationRail({super.key, required this.onNavigate});

  final void Function(int) onNavigate;

  @override
  State<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends State<CustomNavigationRail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: IntrinsicHeight(
          child: NavigationRail(
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
              NavigationRailDestination(icon: Icon(Icons.info), label: Text('Information')),
              NavigationRailDestination(icon: Icon(Icons.quiz), label: Text('Test')),
            ],
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed: () {
                        loginState.logout();
                      }),
                ),
              ),
            ),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
                widget.onNavigate(_selectedIndex);
              });
            },
          ),
        ),
      ),
    );
  }
}
