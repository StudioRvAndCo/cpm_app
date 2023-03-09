import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../models/project.dart';
import '../services/project.dart';
import '../widgets/navigation/custom_appbar.dart';
import '../widgets/navigation/custom_navigation_drawer.dart';
import '../widgets/navigation/custom_navigation_rail.dart';
import 'about.dart';
import 'locations.dart';
import 'members.dart';
import 'projects.dart';
import 'settings.dart';
import 'test.dart';

final GlobalKey<ProjectsState> projectsStateKey = GlobalKey();

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
        return Scaffold(
            appBar: !kIsWeb && (Platform.isAndroid || Platform.isIOS) ? const CustomAppBar() : null,
            drawer: !kIsWeb && (Platform.isAndroid || Platform.isIOS)
                ? CustomNavigationDrawer(
                    selectedIndex: _selectedIndex,
                    onNavigate: (int index) {
                      if (index == 0) {
                        resetPage();
                      }
                      setState(() {
                        _selectedIndex = index;
                      });
                    })
                : null,
            body: SafeArea(
              child: Row(children: <Widget>[
                if (kIsWeb || Platform.isWindows || Platform.isMacOS || Platform.isFuchsia)
                  CustomNavigationRail(onNavigate: (int index) {
                    if (index == 0) {
                      resetPage();
                    }
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
        return Projects(key: projectsStateKey);
      case 1:
        return const Members();
      case 2:
        return const Locations();
      case 3:
        return const Settings();
      case 4:
        return const About();
      case 5:
        return const Test();
      default:
        return const Center();
    }
  }

  /// Resets the home page to the projects list.
  void resetPage() {
    projectsStateKey.currentState?.setState(() {
      projectsStateKey.currentState?.page = ProjectsPage.projects;
    });
  }

  Future<void> addProject() async {
    print('add');
    Project project = Project(
        projectType: ProjectType.movie,
        title: 'Add',
        description: 'Added',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(Duration(days: 1)),
        shotsTotal: 10,
        shotsCompleted: 5,
        episodes: []);
    print(jsonEncode(project.toJson()));
    final List<dynamic> result = await ProjectService().addProject(project);
    print(result[0]);
    print(result[1]);
  }
}
