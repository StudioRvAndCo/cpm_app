import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/project/project.dart';
import '../providers/navigation/navigation.dart';
import '../providers/projects/projects.dart';
import '../utils/constants_globals.dart';
import '../widgets/cards/project_card.dart';
import '../widgets/custom_snack_bars.dart';
import '../widgets/dialogs/project_dialog.dart';
import 'episodes.dart';
import 'planning.dart';
import 'sequences.dart';
import 'shots.dart';

class Projects extends ConsumerStatefulWidget {
  const Projects({required Key key}) : super(key: key);

  @override
  ConsumerState<Projects> createState() => ProjectsState();
}

class ProjectsState extends ConsumerState<Projects> {
  @override
  Widget build(BuildContext context) {
    switch (ref.watch(navigationProvider)) {
      case HomePage.projects:
        return Expanded(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => add(),
              child: const Icon(Icons.add),
            ),
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ref.watch(projectsProvider).when(
                  data: (List<Project> projects) {
                    return MasonryGridView.count(
                      itemCount: projects.length,
                      padding:
                          const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
                      itemBuilder: (BuildContext context, int index) {
                        return ProjectCard(key: UniqueKey(), project: projects[index]);
                      },
                      crossAxisCount: getColumnsCount(constraints),
                      mainAxisSpacing: 2,
                      crossAxisSpacing: 2,
                    );
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return requestPlaceholderError;
                  },
                  loading: () {
                    return requestPlaceholderLoading;
                  },
                );
              },
            ),
          ),
        );
      case HomePage.episodes:
        return Episodes(key: episodesStateKey);
      case HomePage.sequences:
        return const Sequences();
      case HomePage.shots:
        return const Shots();
      case HomePage.planning:
        return const Planning();
    }
  }

  Future<void> add() async {
    final project = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ProjectDialog();
      },
    );
    if (project is Project) {
      ref.read(projectsProvider.notifier).add(project);
      if (true) {
        final String message = true ? 'snack_bars.episode.deleted'.tr() : 'snack_bars.episode.not_deleted'.tr();
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBars().getModelSnackBar(context, true));
      }
    }
  }
}
