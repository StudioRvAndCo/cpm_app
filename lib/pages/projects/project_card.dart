import 'package:cpm/models/project/project.dart';
import 'package:cpm/pages/projects/favorites.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectCard extends ConsumerStatefulWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  late Icon favoriteIcon;

  @override
  void initState() {
    super.initState();
    favoriteIcon = Icon(Favorites().isFavorite(widget.project.getId) ? Icons.star : Icons.star_border);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: () => openProject(widget.project),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.project.getTitle,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 4)),
                        Text(
                          widget.project.getDescription,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(right: 16)),
                  IconButton(
                    onPressed: () => toggleFavorite(widget.project),
                    icon: favoriteIcon,
                  ),
                  IconButton(
                    onPressed: () => openSchedule(widget.project),
                    icon: const Icon(Icons.event),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: widget.project.progress),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> openProject(Project project) async {
    ref.read(currentProjectProvider.notifier).set(project);
    if (project.isMovie) {
      await ref.read(episodesProvider.notifier).set(project.id);
    }
    if (context.mounted) {
      context.pushNamed(project.isMovie ? RouterRoute.sequences.name : RouterRoute.episodes.name);
    }
  }

  Future<void> openSchedule(Project project) async {
    await ref.read(currentProjectProvider.notifier).set(project);
    await ref.read(sequencesProvider.notifier).getAll();
    if (context.mounted) {
      context.pushNamed(RouterRoute.schedule.name);
    }
  }

  void toggleFavorite(Project project) {
    Favorites().isFavorite(project.getId) ? Favorites().remove(project.getId) : Favorites().add(project.getId);
    setState(() {
      favoriteIcon = Icon(Favorites().isFavorite(widget.project.getId) ? Icons.star : Icons.star_border);
    });
    ref.read(projectsProvider.notifier).get(true);
  }
}
