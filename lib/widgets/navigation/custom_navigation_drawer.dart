import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../utils/constants_globals.dart';

class CustomNavigationDrawer extends StatefulWidget {
  const CustomNavigationDrawer({super.key, required this.navigate, required this.selectedIndex});

  final void Function(int) navigate;

  final int selectedIndex;

  @override
  State<CustomNavigationDrawer> createState() => _CustomNavigationDrawerState();
}

class _CustomNavigationDrawerState extends State<CustomNavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: NavigationDrawer(
        selectedIndex: widget.selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            widget.navigate(index);
            Navigator.pop(context);
          });
        },
        children: <Widget>[
          DrawerHeader(
            child: Builder(builder: (BuildContext context) {
              return Theme.of(context).brightness == Brightness.light
                  ? Image.asset(Logos.cpmLight.value, width: 50, filterQuality: FilterQuality.medium)
                  : Image.asset(Logos.cpmDark.value, width: 50, filterQuality: FilterQuality.medium);
            }),
          ),
          NavigationDrawerDestination(icon: const Icon(Icons.movie), label: Text('projects.project.upper'.plural(2))),
          NavigationDrawerDestination(icon: const Icon(Icons.people), label: Text('members.member.upper'.plural(2))),
          NavigationDrawerDestination(icon: const Icon(Icons.map), label: Text('locations.location.upper'.plural(2))),
          NavigationDrawerDestination(icon: const Icon(Icons.settings), label: Text('settings.settings'.tr())),
          NavigationDrawerDestination(icon: const Icon(Icons.info), label: Text('about.about'.tr())),
        ],
      ),
    );
  }
}
