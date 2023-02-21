import 'package:flutter/material.dart';

import '../widgets/custom-appbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int index = 0;
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
        return Scaffold(
            appBar: const CustomAppBar(),
            body: Row(children: <Widget>[
              SafeArea(
                  child: MouseRegion(
                onEnter: (_) => setState(() => expanded = true),
                onExit: (_) => setState(() => expanded = false),
                child: NavigationRail(
                  leading: Image.asset(
                    'assets/logo-cpm-alpha.png',
                    width: 50,
                    filterQuality: FilterQuality.high,
                  ),
                  destinations: const <NavigationRailDestination>[
                    NavigationRailDestination(icon: Icon(Icons.home_outlined), label: Text('Home')),
                    NavigationRailDestination(icon: Icon(Icons.people_outline), label: Text('Members')),
                    NavigationRailDestination(icon: Icon(Icons.map), label: Text('Locations')),
                    NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
                    NavigationRailDestination(icon: Icon(Icons.info), label: Text('Information'))
                  ],
                  onDestinationSelected: (int value) => setState(() {
                    index = value;
                  }),
                  selectedIndex: index,
                  extended: expanded,
                ),
              )),
              Expanded(child: Builder(
                builder: (BuildContext context) {
                  if (boxConstraints.maxWidth > 600) {
                    return const Text('Large');
                  } else {
                    return const Text('Small');
                  }
                },
              ))
            ]));
      },
    );
  }
}
