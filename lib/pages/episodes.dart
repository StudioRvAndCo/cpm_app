import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../services/episode.dart';
import '../widgets/cards/episode.dart';
import '../widgets/info_headers/project.dart';
import '../widgets/request_placeholder.dart';

class Episodes extends StatefulWidget {
  const Episodes({super.key, required this.project, required this.isMovie, required this.openSequences});

  final void Function(Episode episode) openSequences;

  final Project project;
  final bool isMovie;

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  bool requestCompleted = false;
  late bool requestSucceeded;

  late List<Episode> episodes;

  @override
  void initState() {
    super.initState();
    getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    if (!requestCompleted) {
      return const RequestPlaceholder(placeholder: CircularProgressIndicator());
    } else if (requestSucceeded) {
      if (episodes.isEmpty) {
        return RequestPlaceholder(placeholder: Text('episodes.no_episodes'.tr()));
      } else {
        return Expanded(
          child: Column(
            children: <Widget>[
              InfoHeaderProject(project: widget.project),
              Expanded(
                child: CustomScrollView(
                  slivers: <SliverList>[
                    SliverList(
                        delegate: SliverChildBuilderDelegate(
                      childCount: episodes.length,
                      (BuildContext context, int index) {
                        final Episode episode = episodes[index];
                        return EpisodeCard(
                          episode: episode,
                          openSequences: () {
                            widget.openSequences(episode);
                          },
                        );
                      },
                    ))
                  ],
                ),
              ),
            ],
          ),
        );
      }
    } else {
      return RequestPlaceholder(placeholder: Text('errors.request_failed'.tr()));
    }
  }

  Future<void> getEpisodes() async {
    final List<dynamic> result = await EpisodeService().getEpisodes(widget.project.id);
    setState(() {
      requestCompleted = true;
      requestSucceeded = result[0] as bool;
      episodes = result[1] as List<Episode>;
    });

    // If the project is a movie, skip the episodes page and go the sequences page
    if (widget.isMovie) {
      widget.openSequences(episodes.first);
    }
  }
}
