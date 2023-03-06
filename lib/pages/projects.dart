import 'package:flutter/material.dart';

import '../models/project.dart';
import '../services/project.dart';
import '../widgets/project_card.dart';
import 'planning.dart';

enum ProjectsPage { projects, sequences, planning }

class MyNotification extends Notification {
  const MyNotification({required this.title});

  final String title;
}

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  ProjectsPage page = ProjectsPage.projects;
  List<Project> projects = <Project>[];
  late Project planningProject;

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case ProjectsPage.projects:
        return Expanded(
            child: Column(
          children: <ProjectCard>[
            for (Project project in projects)
              ProjectCard(
                project: project,
                openSequences: () {
                  setState(() {
                    page = ProjectsPage.sequences;
                  });
                },
                openPlanning: () {
                  setState(() {
                    planningProject = project;
                    page = ProjectsPage.planning;
                  });
                },
              )
          ],
        ));
      case ProjectsPage.sequences:
        return const Center(child: Text('Sequences'));
      case ProjectsPage.planning:
        return Planning(project: planningProject);
    }
  }

  Future<void> getProjects() async {
    final List<dynamic> result = await ProjectService().getProjects();
    setState(() {
      projects = result[1] as List<Project>;
    });
  }
}
