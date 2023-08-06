import 'package:cpm/providers/episodes/episodes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project/project.dart';
import '../../providers/navigation/navigation.dart';
import '../../providers/projects/projects.dart';
import '../../utils/constants_globals.dart';

class ProjectCard extends ConsumerStatefulWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  Icon favoriteIcon = const Icon(Icons.star_border);

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
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
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
              IconButton(onPressed: () => toggleFavorite(widget.project), icon: favoriteIcon),
              IconButton(onPressed: () => openSchedule(widget.project), icon: const Icon(Icons.event)),
            ]),
            const SizedBox(height: 8),
            LinearProgressIndicator(value: widget.project.progress),
          ]),
        ),
      ),
    );
  }

  Future<void> openProject(Project project) async {
    ref.read(currentProjectProvider.notifier).set(project);
    if (project.isMovie) {
      await ref.read(episodesProvider.notifier).set(project.id);
    }
    ref.read(navigationProvider.notifier).set(project.isMovie ? HomePage.sequences : HomePage.episodes);
  }

  Future<void> openSchedule(Project project) async {
    ref.read(currentProjectProvider.notifier).set(project);

    if (project.isMovie) {
      await ref.read(episodesProvider.notifier).set(project.id);
    }
    ref.read(navigationProvider.notifier).set(HomePage.schedule);
  }

  void toggleFavorite(Project project) {
    project.toggleFavorite();
    setState(() {
      favoriteIcon = widget.project.favorite
          ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
          : const Icon(Icons.star_border);
    });
  }
}
