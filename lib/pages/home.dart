import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/location.dart';
import '../models/member.dart';
import '../widgets/custom_appbar.dart';
import 'information.dart';
import 'locations.dart';
import 'members.dart';
import 'planning.dart';
import 'projects.dart';
import 'test.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
        return Scaffold(
            appBar: !kIsWeb && (Platform.isAndroid || Platform.isIOS) ? const CustomAppBar() : null,
            drawer: !kIsWeb && (Platform.isAndroid || Platform.isIOS) ? buildNavigationDrawer() : null,
            body: Row(children: <Widget>[
              if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isFuchsia)
                SafeArea(child: buildNavigationRail()),
              _pageAtIndex(_selectedIndex),
            ]));
      },
    );
  }

  PreferredSize buildNavigationDrawer() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(kToolbarHeight),
      child: NavigationDrawer(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
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

  SingleChildScrollView buildNavigationRail() {
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
              NavigationRailDestination(icon: Icon(Icons.calendar_today), label: Text('Planning')),
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
              });
            },
          ),
        ),
      ),
    );
  }

  static Widget _pageAtIndex(int index) {
    switch (index) {
      case 0:
        return const Projects();
      case 1:
        return const Members(
          members: <Member>[Member(firstName: 'Paul', lastName: 'Issière', phone: '69')],
        );
      case 2:
        return Locations(
          locations: <Location>[
            Location('Polytech Grenoble',
                "Polytech Grenoble, 14 Place du Conseil National de la Résistance, 38400 Saint-Martin-d'Hères"),
            Location('Tour Perret', 'Tour Perret, Parc Paul Mistral, Bd Jean Pain, 38000 Grenoble'),
          ],
        );
      case 3:
        return const Planning();
      case 4:
        return const Information();
      case 5:
        return const Test();
      default:
        return const Center(child: Text('TODO'));
    }
  }
}
