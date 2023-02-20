import 'package:flutter/material.dart';

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return DesktopHomePageState();
  }
}

class DesktopHomePageState extends State<DesktopHomePage> {
  int index = 0;
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Cinema Project Manager'),
              centerTitle: boxConstraints.maxWidth < 600,
            ),
            body: Row(children: [
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
                  destinations: const [
                    NavigationRailDestination(
                        icon: Icon(Icons.home_outlined), label: Text('Home')),
                    NavigationRailDestination(
                        icon: Icon(Icons.people_outline),
                        label: Text('Members')),
                    NavigationRailDestination(
                        icon: Icon(Icons.map), label: Text('Locations')),
                    NavigationRailDestination(
                        icon: Icon(Icons.settings), label: Text('Settings')),
                    NavigationRailDestination(
                        icon: Icon(Icons.info), label: Text('Information'))
                  ],
                  onDestinationSelected: (int value) => setState(() {
                    index = value;
                  }),
                  selectedIndex: index,
                  extended: expanded,
                ),
              )),
              Expanded(child: Builder(
                builder: (context) {
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
