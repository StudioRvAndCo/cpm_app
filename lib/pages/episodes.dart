import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../services/episode.dart';
import '../widgets/episode_card.dart';

class Episodes extends StatefulWidget {
  const Episodes({super.key, required this.projectId, required this.openSequences});

  final void Function(Episode episode) openSequences;

  final String projectId;

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  late List<Episode> episodes;

  @override
  void initState() {
    super.initState();
    getEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    if (episodes.isEmpty) {
      return Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text('No episodes in this project.'),
          ],
        ),
      );
    } else {
      return Expanded(
          child: Column(
        children: <EpisodeCard>[
          for (Episode episode in episodes)
            EpisodeCard(
              episode: episode,
              openSequences: () {
                widget.openSequences(episode);
              },
            )
        ],
      ));
    }
  }

  Future<void> getEpisodes() async {
    final List<dynamic> result = await EpisodeService().getEpisodes(widget.projectId);
    setState(() {
      episodes = result[1] as List<Episode>;
    });
  }
}
