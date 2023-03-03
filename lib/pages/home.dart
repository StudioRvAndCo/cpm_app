import 'dart:io' show Platform;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../main.dart';
import '../models/location.dart';
import '../models/member.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../widgets/custom_appbar.dart';
import 'information.dart';
import 'locations.dart';
import 'members.dart';
import 'planning.dart';
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
                ? buildNavigationDrawer()
                : null,
            body: SafeArea(
              child: Row(children: <Widget>[
                if (kIsWeb ||
                    Platform.isWindows ||
                    Platform.isMacOS ||
                    Platform.isFuchsia)
                  buildNavigationRail(),
                _pageAtIndex(_selectedIndex),
              ]),
            ));
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
          DrawerHeader(child: Builder(
            builder: (BuildContext context) {
              if (Theme.of(context).brightness == Brightness.light) {
                return Image.asset(
                  'assets/images/logo-cpm-alpha.png',
                  filterQuality: FilterQuality.high,
                );
              } else {
                return Image.asset(
                  'assets/images/logo-cpm-white-alpha.png',
                  filterQuality: FilterQuality.high,
                );
              }
            },
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
              icon: const Icon(Icons.event),
              label: Text('planning.upper'.tr())),
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

  SingleChildScrollView buildNavigationRail() {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints:
            BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: IntrinsicHeight(
          child: NavigationRail(
            leading: Builder(
              builder: (BuildContext context) {
                if (Theme.of(context).brightness == Brightness.light) {
                  return Image.asset(
                    'assets/images/logo-cpm-alpha.png',
                    width: 50,
                    filterQuality: FilterQuality.high,
                  );
                } else {
                  return Image.asset(
                    'assets/images/logo-cpm-white-alpha.png',
                    width: 50,
                    filterQuality: FilterQuality.high,
                  );
                }
              },
            ),
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(
                  icon: const Icon(Icons.home_outlined),
                  label: Text('home'.tr())),
              NavigationRailDestination(
                  icon: const Icon(Icons.people_outline),
                  label: Text('members.member.upper'.plural(2))),
              NavigationRailDestination(
                  icon: const Icon(Icons.map),
                  label: Text('locations.location.upper'.plural(2))),
              NavigationRailDestination(
                  icon: const Icon(Icons.event),
                  label: Text('planning.upper'.tr())),
              NavigationRailDestination(
                  icon: const Icon(Icons.settings),
                  label: Text('settings'.tr())),
              NavigationRailDestination(
                  icon: const Icon(Icons.info),
                  label: Text('information'.tr())),
              const NavigationRailDestination(
                  icon: Icon(Icons.quiz), label: Text('Test')),
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
        return Planning(
          project: Project(
              projectType: ProjectType.movie,
              title: 'Jaj',
              beginDate: DateTime.utc(2023, 2, 25),
              endDate: DateTime.utc(2023, 3, 11),
              sequences: <Sequence>[
                Sequence(
                    title: 'seq1',
                    date: DateTime.utc(2023, 2, 27),
                    startTime: DateTime.utc(2023, 3, 11, 10, 30),
                    endTime: DateTime.utc(2023, 3, 11, 10, 45)),
                Sequence(
                    title: 'seq2',
                    date: DateTime.utc(2023, 3, 2),
                    startTime: DateTime.utc(2023, 3, 2, 13, 45),
                    endTime: DateTime.utc(2023, 3, 2, 15, 55)),
                Sequence(
                    title: 'seq3',
                    date: DateTime.utc(2023, 3, 2),
                    startTime: DateTime.utc(2023, 3, 2, 16, 45),
                    endTime: DateTime.utc(2023, 3, 2, 17, 55)),
              ]),
        );
      case 4:
        return const Settings();
      case 5:
        return const Information();
      case 6:
        return const Test();
      default:
        return const Center(child: Text('TODO'));
    }
  }
}
