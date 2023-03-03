import 'package:flutter/material.dart';

import '../models/project.dart';
import '../widgets/project_card.dart';
import '../widgets/subproject_card.dart';
import 'planning.dart';

enum Page { projects, sequences, planning }

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  late Page page;

  @override
  void initState() {
    super.initState();
    page = Page.projects;
  }

  @override
  Widget build(BuildContext context) {
    final ProjectCard project = ProjectCard(
      title: 'En Sursis',
      favorite: false,
      image: Image.asset('assets/en-sursis.png'),
      shotsCompleted: 3,
      shotsTotal: 12,
      openPlanning: () {
        setState(() {
          page = Page.planning;
        });
      },
      openSequences: () {
        setState(() {
          page = Page.sequences;
        });
      },
    );

    const SubProjectCard subProjectCard = SubProjectCard(
        number: 1,
        title: 'Titre',
        description: 'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM',
        shotsTotal: 15,
        shotsCompleted: 2);

    switch (page) {
      case Page.projects:
        return Expanded(
            child: Column(
          children: <Widget>[
            project,
            project,
            subProjectCard,
          ],
        ));
      case Page.sequences:
        return const Center(child: Text('Sequences'));
      case Page.planning:
        return Planning(
            project: Project(
                projectType: ProjectType.movie,
                title: 'Project',
                beginDate: DateTime(2023, 02, 03),
                endDate: DateTime(2023, 04, 04),
                sequences: []));
    }
  }
}
