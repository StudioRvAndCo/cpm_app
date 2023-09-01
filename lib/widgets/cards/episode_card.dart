import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/episode/episode.dart';
import '../../providers/episodes/episodes.dart';
import '../../providers/navigation/navigation.dart';
import '../../utils/constants_globals.dart';

class EpisodeCard extends ConsumerStatefulWidget {
  const EpisodeCard({super.key, required this.episode});

  final Episode episode;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EpisodeCardState();
}

class _EpisodeCardState extends ConsumerState<EpisodeCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        ),
        onPressed: () => openEpisode(widget.episode),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            Row(children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: 30,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: const BorderRadius.all(Radius.circular(15)),
                          ),
                          child: Text(
                            widget.episode.number.toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(right: 12)),
                        Text(
                          widget.episode.getTitle,
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 4)),
                    Text(
                      widget.episode.getDescription,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ]),
          ]),
        ),
      ),
    );
  }

  void openEpisode(Episode episode) {
    ref.read(currentEpisodeProvider.notifier).set(episode);
    ref.read(navigationProvider.notifier).set(HomePage.sequences);
  }
}
