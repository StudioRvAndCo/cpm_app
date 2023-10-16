import 'package:cpm/common/grid_view.dart';
import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/pages/projects/project_card.dart';
import 'package:cpm/pages/projects/project_dialog.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectsPage extends ConsumerStatefulWidget {
  const ProjectsPage({super.key});

  @override
  ConsumerState<ProjectsPage> createState() => ProjectsState();
}

class ProjectsState extends ConsumerState<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
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
    );
  }

  Future<void> add() async {
    final project = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ProjectDialog();
      },
    );
    if (project is Project) {
      final added = await ref.read(projectsProvider.notifier).add(project);
      SnackBarManager().show(
        added
            ? getInfoSnackBar(
                localizations.snack_bar_add_success_item(localizations.item_project, Gender.male.name),
              )
            : getErrorSnackBar(
                localizations.snack_bar_add_fail_item(localizations.item_project, Gender.male.name),
              ),
      );
    }
  }
}
