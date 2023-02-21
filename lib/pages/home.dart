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
            appBar: MediaQuery.of(context).size.width <= 600 ? const CustomAppBar() : null,
            drawer: MediaQuery.of(context).size.width <= 600 ? const CustomDrawer() : null,
            body: Row(children: [
              if (MediaQuery.of(context).size.width > 600)
                const SafeArea(child: CustomRail(index: 0))
              else
                const SizedBox.shrink(),
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
