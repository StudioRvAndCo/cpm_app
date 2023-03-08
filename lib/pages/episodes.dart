import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../services/episode.dart';
import '../widgets/episode_card.dart';
import '../widgets/icon_label.dart';
import '../widgets/info_header.dart';

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
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            CircularProgressIndicator(),
          ],
        ),
      );
    } else if (requestSucceeded) {
      if (episodes.isEmpty) {
        return Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text('No episodes.'),
            ],
          ),
        );
      } else {
        return Expanded(
          child: Column(
            children: [
              InfoHeader(
                  title: widget.project.title,
                  description: widget.project.description,
                  dateRange: DateTimeRange(start: widget.project.beginDate, end: widget.project.endDate),
                  progress: (widget.project.shotsCompleted ?? 0) / (widget.project.shotsTotal ?? 1),
                  leftLabel: IconLabel(text: widget.project.director ?? '', icon: Icons.movie_outlined),
                  rightLabel: IconLabel(text: widget.project.writer ?? '', icon: Icons.description_outlined)),
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
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('Request failed.'),
          ],
        ),
      );
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
