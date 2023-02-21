import 'package:flutter/material.dart';

import '../widgets/custom-appbar.dart';
import '../widgets/project_card.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int index = 0;

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
            appBar: MediaQuery.of(context).size.width <= 600 ? const CustomAppBar() : null,
            drawer: MediaQuery.of(context).size.width <= 600
                ? SafeArea(
                    child: NavigationDrawer(children: [
                      Image.asset('assets/logo-cpm-alpha.png'),
                      const NavigationDrawerDestination(icon: Icon(Icons.home_outlined), label: Text('Home')),
                      const NavigationDrawerDestination(icon: Icon(Icons.people_outline), label: Text('Members')),
                      const NavigationDrawerDestination(icon: Icon(Icons.map), label: Text('Locations')),
                      const NavigationDrawerDestination(icon: Icon(Icons.settings), label: Text('Settings')),
                      const NavigationDrawerDestination(icon: Icon(Icons.info), label: Text('Informations'))
                    ]),
                  )
                : null,
            body: Row(children: [
              if (MediaQuery.of(context).size.width > 600)
                SafeArea(
                  child: NavigationRail(
                      leading: Image.asset(
                        'assets/logo-cpm-alpha.png',
                        width: 50,
                        filterQuality: FilterQuality.high,
                      ),
                      labelType: NavigationRailLabelType.all,
                      destinations: const [
                        NavigationRailDestination(icon: Icon(Icons.home_outlined), label: Text('Home')),
                        NavigationRailDestination(icon: Icon(Icons.people_outline), label: Text('Members')),
                        NavigationRailDestination(icon: Icon(Icons.map), label: Text('Locations')),
                        NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
                        NavigationRailDestination(icon: Icon(Icons.info), label: Text('Informations'))
                      ],
                      onDestinationSelected: (value) => setState(() {
                            index = value;
                          }),
                      selectedIndex: index),
                )
              else
                SizedBox.shrink(),
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
