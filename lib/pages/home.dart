import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import '../widgets/custom_appbar.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/custom_rail.dart';
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
      builder: (BuildContext buildContext, BoxConstraints boxConstraints) {
        return Scaffold(
            appBar: Platform.isAndroid || Platform.isIOS ? const CustomAppBar() : null,
            drawer: Platform.isAndroid || Platform.isIOS ? const CustomDrawer() : null,
            body: Row(children: <Widget>[
              if (!Platform.isAndroid && !Platform.isIOS) const SafeArea(child: CustomRail()),
              Expanded(
                  child: ListView(
                children: <ProjectCard>[
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
