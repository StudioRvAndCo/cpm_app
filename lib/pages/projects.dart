import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../services/project.dart';
import '../widgets/project_card.dart';
import '../widgets/request_placeholder.dart';
import 'episodes.dart';
import 'planning.dart';
import 'sequences.dart';
import 'shots.dart';

enum ProjectsPage { projects, episodes, sequences, shots, planning }

class Projects extends StatefulWidget {
  const Projects({required Key key}) : super(key: key);

  @override
  State<Projects> createState() => ProjectsState();
}

class ProjectsState extends State<Projects> {
  ProjectsPage page = ProjectsPage.projects;

  bool requestCompleted = false;
  late bool requestSucceeded;
  late List<Project> projects;

  late Project selectedProject;
  late Episode selectedEpisode;
  late Sequence selectedSequence;

  @override
  void initState() {
    super.initState();
    getProjects();
  }

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case ProjectsPage.projects:
        if (!requestCompleted) {
          return const RequestPlaceholder(placeholder: CircularProgressIndicator());
        } else if (requestSucceeded) {
          if (projects.isEmpty) {
            return RequestPlaceholder(placeholder: Text('projects.no_projects'.tr()));
          } else {
            return Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: projects.length,
                    (BuildContext context, int index) {
                      final Project project = projects[index];
                      return ProjectCard(
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
                      );
                    },
                  ))
                ],
              ),
            );
          }
        } else {
          return RequestPlaceholder(placeholder: Text('errors.request_failed'.tr()));
        }
      case ProjectsPage.episodes:
        return Episodes(
          project: selectedProject,
          isMovie: selectedProject.projectType == ProjectType.movie,
          openSequences: (Episode episode) {
            setState(() {
              selectedEpisode = episode;
              page = ProjectsPage.sequences;
            });
          },
        );
      case ProjectsPage.sequences:
        return Sequences(
          sequences: selectedEpisode.sequences,
          openShots: (Sequence sequence) {
            setState(() {
              selectedSequence = sequence;
              page = ProjectsPage.shots;
            });
          },
        );
      case ProjectsPage.shots:
        return Shots(shots: selectedSequence.shots);
      case ProjectsPage.planning:
        return Planning(project: selectedProject);
    }
  }

  Future<void> getProjects() async {
    final List<dynamic> result = await ProjectService().getProjects();
    setState(() {
      requestCompleted = true;
      requestSucceeded = result[0] as bool;
      projects = result[1] as List<Project>;
    });
  }
}
