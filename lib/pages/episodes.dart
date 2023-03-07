import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../widgets/episode_card.dart';

class Episodes extends StatefulWidget {
  const Episodes({super.key, required this.episodes, required this.openSequences});

  final void Function(Episode episode) openSequences;

  final List<Episode> episodes;

  @override
  State<Episodes> createState() => _EpisodesState();
}

class _EpisodesState extends State<Episodes> {
  @override
  Widget build(BuildContext context) {
    if (widget.episodes.isEmpty) {
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
              for (Episode episode in widget.episodes)
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
}
