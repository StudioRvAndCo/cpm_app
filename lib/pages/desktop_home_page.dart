import 'package:flutter/material.dart';

import '../widgets/project_card.dart';

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
    final ProjectCard project = ProjectCard(
      title: 'En Sursis',
      favorite: false,
      image: Image.asset('assets/en-sursis.png'),
      shotsCompleted: 3,
      shotsTotal: 12,
    );
    return LayoutBuilder(
      builder: (BuildContext, BoxConstraints) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Cinema Project Manager'),
              centerTitle: BoxConstraints.maxWidth < 600,
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
                        icon: Icon(Icons.info), label: Text('Informations'))
                  ],
                  onDestinationSelected: (value) => setState(() {
                    index = value;
                  }),
                  selectedIndex: index,
                  extended: expanded,
                ),
              )),
              Expanded(
                  child: ListView(
                children: [
                  project,
                  project,
                  project,
                  project,
                  project,
                  project,
                  project,
                  project,
                  project,
                  project,
                  project,
                  project,
                ],
              ))
            ]));
      },
    );
  }
}
