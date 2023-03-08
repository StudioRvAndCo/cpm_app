import 'package:flutter/material.dart';

import '../../models/project.dart';

class ProjectCard extends StatefulWidget {
  const ProjectCard({super.key, required this.project, required this.openEpisodes, required this.openPlanning});

  final void Function() openEpisodes;
  final void Function() openPlanning;

  final Project project;

  @override
  State<StatefulWidget> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    Icon favIcon =
        favorite ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary) : const Icon(Icons.star_border);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          onPressed: widget.openEpisodes,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(children: <Widget>[
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset('assets/images/en-sursis.png'),
                ),
                const Padding(padding: EdgeInsets.only(right: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.project.title,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 4)),
                      Text(
                        widget.project.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 16)),
                IconButton(
                    onPressed: () {
                      toggleFavorite();
                      setState(() {
                        favIcon = const Icon(Icons.star);
                      });
                    },
                    icon: favIcon),
                IconButton(
                    onPressed: () {
                      widget.openPlanning();
                    },
                    icon: const Icon(Icons.event))
              ]),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: (widget.project.shotsCompleted ?? 1) / (widget.project.shotsTotal ?? 1)),
            ]),
          )),
    );
  }

  void toggleFavorite() {
    favorite = !favorite;
  }
}
