import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../models/location.dart';
import '../models/member.dart';
import '../widgets/custom_appbar.dart';
import '../widgets/custom_navigation_drawer.dart';
import '../widgets/custom_navigation_rail.dart';
import 'information.dart';
import 'locations.dart';
import 'members.dart';
import 'projects.dart';
import 'settings.dart';
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
            appBar: !kIsWeb && (Platform.isAndroid || Platform.isIOS)
                ? const CustomAppBar()
                : null,
            drawer: !kIsWeb && (Platform.isAndroid || Platform.isIOS)
                ? CustomNavigationDrawer(onNavigate: (int index) {
                    _selectedIndex = index;
                  })
                : null,
            body: SafeArea(
              child: Row(children: <Widget>[
                if (kIsWeb ||
                    Platform.isWindows ||
                    Platform.isMacOS ||
                    Platform.isFuchsia)
                  CustomNavigationRail(onNavigate: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  }),
                _changePage(_selectedIndex),
              ]),
            ));
      },
    );
  }

  Widget _changePage(int index) {
    switch (index) {
      case 0:
        return const Projects();
      case 1:
        return Members(
          members: <Member>[
            Member(firstName: 'Paul', lastName: 'Issière', phone: '69')
          ],
        );
      case 2:
        return Locations(
          locations: <Location>[
            Location(
                id: '1',
                name: 'Polytech Grenoble',
                position: "Polytech Grenoble, 38400 Saint-Martin-d'Hères"),
            Location(
              id: '2',
              name: 'Tour Perret',
            ),
          ],
        );
      case 3:
        return const Settings();
      case 4:
        return const Information();
      case 5:
        return const Test();
      default:
        return const Center(child: Text('TODO'));
    }
  }
}
