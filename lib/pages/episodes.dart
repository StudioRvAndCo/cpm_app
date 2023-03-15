import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../dialogs/new_episode.dart';
import '../models/episode.dart';
import '../models/project.dart';
import '../services/episode.dart';
import '../widgets/cards/episode.dart';
import '../widgets/info_headers/project.dart';
import '../widgets/request_placeholder.dart';
import '../widgets/snack_bars.dart';

class Episodes extends StatefulWidget {
  const Episodes({super.key, required this.project, required this.openSequences});

  final void Function(Episode episode) openSequences;

  final Project project;

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
      return const Expanded(child: RequestPlaceholder(placeholder: CircularProgressIndicator()));
    } else if (requestSucceeded) {
      return Expanded(
          child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () => addEpisode,
        ),
        body: Builder(builder: (BuildContext context) {
          if (episodes.isEmpty) {
            return RequestPlaceholder(placeholder: Text('episodes.no_episodes'.tr()));
          } else {
            return ListView(
              padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64),
              children: <Widget>[
                InfoHeaderProject(project: widget.project),
                ...episodes.map((Episode episode) {
                  return EpisodeCard(
                    episode: episode,
                    openSequences: () {
                      setState(() {
                        widget.openSequences(episode);
                      });
                    },
                  );
                }),
              ],
            );
          }
        }),
      ));
    } else {
      return Expanded(child: RequestPlaceholder(placeholder: Text('error.request_failed'.tr())));
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
    if (widget.project.isMovie()) {
      widget.openSequences(episodes.first);
    }
  }

  Future<void> addEpisode() async {
    final dynamic episode = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return NewEpisodeDialog(number: episodes.length + 1);
        });
    if (episode is Episode) {
      final List<dynamic> result = await EpisodeService().addEpisode(widget.project.id, episode);
      if (context.mounted) {
        final bool succeeded = result[0] as bool;
        ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar().getModelSnackBar(
            context, succeeded, result[1] as int,
            message: succeeded ? 'snack_bars.episode.added'.tr() : 'snack_bars.episode.not_added'.tr()));
      }
      setState(() {
        getEpisodes();
      });
    }
  }
}
