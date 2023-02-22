import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../widgets/custom_appbar.dart';
import 'login.dart';
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
              if (kIsWeb || Platform.isWindows && Platform.isMacOS || Platform.isFuchsia)
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

  NavigationRail buildNavigationRail() {
    return NavigationRail(
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
                  Navigator.push(
                      context, PageTransition<Login>(type: PageTransitionType.topToBottom, child: const Login()));
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
    );
  }

  static Widget _pageAtIndex(int index) {
    switch (index) {
      case 0:
        return const Projects();
      case 5:
        return const Test();
      default:
        return const Center(child: Text('TODO'));
    }
  }
}
