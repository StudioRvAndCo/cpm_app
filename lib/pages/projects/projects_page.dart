import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/common/placeholders/empty_placeholder.dart';
import 'package:cpm/common/widgets/project_card.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/pages/projects/favorites.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/pages.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectsPage extends ConsumerStatefulWidget {
  const ProjectsPage({super.key});

  @override
  ConsumerState<ProjectsPage> createState() => ProjectsState();
}

class ProjectsState extends ConsumerState<ProjectsPage> {
  Future<void> _refresh() async {
    await ref.read(projectsProvider.notifier).get();
  }

  Future<void> _open(Project project) async {
    ref.read(currentProjectProvider.notifier).set(project);
    if (project.isMovie) {
      await ref.read(episodesProvider.notifier).set(project.id);
    }
    if (context.mounted) {
      context.pushNamed(project.isMovie ? RouterRoute.sequences.name : RouterRoute.episodes.name);
    }
  }

  Future<void> _openSchedule(Project project) async {
    await ref.read(currentProjectProvider.notifier).set(project);
    await ref.read(sequencesProvider.notifier).getAll();
    if (context.mounted) {
      context.pushNamed(RouterRoute.schedule.name);
    }
  }

  void _toggleFavorite(Project project) {
    Favorites().isFavorite(project.getId) ? Favorites().remove(project.getId) : Favorites().add(project.getId);
    ref.read(projectsProvider.notifier).get(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddAction<Project>().add(context, ref),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: ScrollConfiguration(
          behavior: scrollBehavior,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ref.watch(projectsProvider).when(
                data: (projects) {
                  return projects.isEmpty
                      ? CustomPlaceholder.empty(EmptyPlaceholder.projects)
                      : MasonryGridView.count(
                          itemCount: projects.length,
                          padding: Paddings.withFab(Paddings.custom.page),
                          itemBuilder: (BuildContext context, int index) {
                            return ProjectCard.project(
                              key: UniqueKey(),
                              open: () => _open(projects[index]),
                              title: projects[index].title,
                              description: projects[index].description,
                              progress: projects[index].progress,
                              progressText: projects[index].progressText,
                              trailing: [
                                IconButton(
                                  onPressed: () => _toggleFavorite(projects[index]),
                                  icon: Icon(
                                    Favorites().isFavorite(projects[index].getId) ? Icons.star : Icons.star_border,
                                  ),
                                ),
                                Padding(padding: Paddings.padding2.horizontal),
                                IconButton(
                                  onPressed: () => _openSchedule(projects[index]),
                                  icon: const Icon(Icons.event),
                                ),
                              ],
                            );
                          },
                          crossAxisCount: getColumnsCount(constraints),
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        );
                },
                error: (Object error, StackTrace stackTrace) {
                  return CustomPlaceholder.error();
                },
                loading: () {
                  return CustomPlaceholder.loading();
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
