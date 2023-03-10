import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../dialogs/new_project.dart';
import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../services/project.dart';
import '../settings.dart';
import '../widgets/cards/project.dart';
import '../widgets/request_placeholder.dart';
import '../widgets/snack_bars.dart';
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
    getProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (page) {
      case ProjectsPage.projects:
        if (!requestCompleted) {
          return const RequestPlaceholder(
              placeholder: CircularProgressIndicator());
        } else if (requestSucceeded) {
          if (projects.isEmpty) {
            return RequestPlaceholder(
                placeholder: Text('projects.no_projects'.tr()));
          } else {
            return ChangeNotifierProvider<ModelFav>(
              create: (_) => ModelFav(),
              child: Consumer<ModelFav>(builder:
                  (BuildContext context, ModelFav favNotifier, Widget? child) {
                getFavorites(favNotifier);
                return Expanded(
                  child: Stack(
                    children: <Widget>[
                      CustomScrollView(
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
                                  favNotifier: favNotifier);
                            },
                          ))
                        ],
                      ),
                      Positioned(
                          bottom: 16,
                          right: 16,
                          child: FloatingActionButton(
                            onPressed: () {
                              addProject();
                            },
                            child: const Icon(Icons.add),
                          ))
                    ],
                  ),
                );
              }),
            );
          }
        } else {
          return RequestPlaceholder(
              placeholder: Text('errors.request_failed'.tr()));
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
          project: selectedProject,
          episode: selectedEpisode,
          openShots: (Sequence sequence) {
            setState(() {
              selectedSequence = sequence;
              page = ProjectsPage.shots;
            });
          },
        );
      case ProjectsPage.shots:
        return Shots(sequence: selectedSequence);
      case ProjectsPage.planning:
        return Planning(project: selectedProject);
    }
  }

  void getFavorites(ModelFav favNotifier) {
    final List<String> favorites = favNotifier.favoriteProjects;
    for (final String id in favorites) {
      for (final Project project in projects) {
        if (id == project.id) {
          project.favorite = true;
        }
      }
    }
    projects.sort();
  }

  Future<void> getProjects() async {
    final List<dynamic> result = await ProjectService().getProjects();
    setState(() {
      requestCompleted = true;
      requestSucceeded = result[0] as bool;
      projects = result[1] as List<Project>;
    });
  }

  Future<void> addProject() async {
    final dynamic project = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const NewProjectDialog();
        });
    if (project is Project) {
      final List<dynamic> result = await ProjectService().addProject(project);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            PopupSnackBar().getNewProjectSnackBar(context, result[0] as bool));
      }
      setState(() {
        getProjects();
      });
    }
  }
}
