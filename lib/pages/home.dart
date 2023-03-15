import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import '../widgets/navigation/custom_appbar.dart';
import '../widgets/navigation/custom_navigation_drawer.dart';
import '../widgets/navigation/custom_navigation_rail.dart';
import 'about.dart';
import 'episodes.dart';
import 'locations.dart';
import 'members.dart';
import 'projects.dart';
import 'settings.dart';
import 'test.dart';

final GlobalKey<ProjectsState> projectsStateKey = GlobalKey();
final GlobalKey<EpisodesState> episodesStateKey = GlobalKey();

/// Resets the home page to the desired page.
void resetPage(ProjectsPage page) {
  projectsStateKey.currentState?.setState(() {
    switch (page) {
      case ProjectsPage.projects:
        projectsStateKey.currentState?.requestCompleted = false;
        projectsStateKey.currentState?.getProjects();
        break;
      case ProjectsPage.episodes:
        episodesStateKey.currentState?.requestCompleted = false;
        episodesStateKey.currentState?.getEpisodes();
        break;
      case ProjectsPage.sequences:
      case ProjectsPage.shots:
      case ProjectsPage.planning:
        break;
    }
    projectsStateKey.currentState?.page = page;
  });
}

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
                        resetPage(ProjectsPage.projects);
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
                      resetPage(ProjectsPage.projects);
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
}
