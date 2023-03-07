import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../services/project.dart';
import '../widgets/project_card.dart';
import 'episodes.dart';
import 'planning.dart';
import 'sequences.dart';

enum ProjectsPage { projects, episodes, sequences, shots, planning }

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  ProjectsPage page = ProjectsPage.projects;
  List<Project> projects = <Project>[];

  late Project selectedProject;
  late Episode selectedEpisode;

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case ProjectsPage.projects:
        if (projects.isEmpty) {
          return Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          return Expanded(
              child: Column(
            children: <ProjectCard>[
              for (Project project in projects)
                ProjectCard(
                  project: project,
                  openEpisodes: () {
                    setState(() {
                      selectedProject = project;
                      page = ProjectsPage.episodes;
                    });
                  },
                  openPlanning: () {
                    setState(() {
                      selectedProject = project;
                      page = ProjectsPage.planning;
                    });
                  },
                )
            ],
          ));
        }
      case ProjectsPage.episodes:
        return Episodes(
          episodes: selectedProject.episodes,
          openSequences: (Episode episode) {
            setState(() {
              selectedEpisode = episode;
              page = ProjectsPage.sequences;
            });
          },
        );
      case ProjectsPage.sequences:
        return Sequences(sequences: selectedEpisode.sequences);
      case ProjectsPage.shots:
        return Center();
        break;
      case ProjectsPage.planning:
        return Planning(project: selectedProject);
    }
  }

  Future<void> getProjects() async {
    final List<dynamic> result = await ProjectService().getProjects();
    setState(() {
      projects = result[1] as List<Project>;
    });
  }
}
