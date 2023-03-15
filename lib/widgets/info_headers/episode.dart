import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../dialogs/confirm_dialog.dart';
import '../../models/episode.dart';
import '../../pages/home.dart';
import '../../pages/projects.dart';
import '../../services/episode.dart';
import '../info_sheets/episode.dart';
import '../snack_bars.dart';

class InfoHeaderEpisode extends StatefulWidget {
  const InfoHeaderEpisode({super.key, required this.projectID, required this.episode});

  final String projectID;
  final Episode episode;

  @override
  State<InfoHeaderEpisode> createState() => _InfoHeaderEpisodeState();
}

class _InfoHeaderEpisodeState extends State<InfoHeaderEpisode> {
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
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        widget.episode.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: deleteEpisode,
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    )
                  ],
                ),
                const Padding(padding: EdgeInsets.only(bottom: 8)),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(widget.episode.description, maxLines: 2, overflow: TextOverflow.ellipsis)),
                Row(children: <Widget>[
                  if (widget.episode.director != null) ...<Widget>[
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    const Flexible(child: Icon(Icons.movie_outlined))
                  ],
                  if (widget.episode.writer != null) ...<Widget>[
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
              return InfoSheetEpisode(episode: widget.episode);
            });
      },
    );
  }

  Future<void> deleteEpisode() async {
    showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) async {
      if (result ?? false) {
        final List<dynamic> result = await EpisodeService().deleteEpisode(widget.projectID, widget.episode.id);
        if (context.mounted) {
          final bool succeeded = result[0] as bool;
          ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar().getModelSnackBar(
              context, succeeded, result[1] as int,
              message: succeeded ? 'snack_bars.episode.deleted'.tr() : 'snack_bars.episode.not_deleted'.tr()));
        }
        resetPage(ProjectsPage.episodes);
      }
    });
  }
}
