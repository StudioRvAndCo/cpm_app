import 'package:flutter/material.dart';

import '../../models/episode.dart';
import '../info_sheets/episode.dart';

class InfoHeaderEpisode extends StatelessWidget {
  const InfoHeaderEpisode({super.key, required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: const ContinuousRectangleBorder(),
          backgroundColor: Theme.of(context).colorScheme.background),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(episode.title,
                        style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(episode.description, maxLines: 2, overflow: TextOverflow.ellipsis)),
                Row(children: <Widget>[
                  if (episode.director != null) ...<Widget>[
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    const Flexible(child: Icon(Icons.movie_outlined))
                  ],
                  if (episode.writer != null) ...<Widget>[
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    const Flexible(child: Icon(Icons.description_outlined))
                  ]
                ])
              ],
            ),
          ),
          //_getCardContent(context),
        ],
      ),
      onPressed: () {
        showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return InfoSheetEpisode(episode: episode);
            });
      },
    );
  }
}
