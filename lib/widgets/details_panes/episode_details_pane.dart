import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/episode/episode.dart';
import '../../models/project/project.dart';
import '../../providers/episodes/episodes.dart';
import '../../providers/projects/projects.dart';
import '../../utils/constants_globals.dart';

class EpisodeDetailsPane extends ConsumerStatefulWidget {
  const EpisodeDetailsPane({super.key});

  @override
  ConsumerState<EpisodeDetailsPane> createState() => _DetailsPaneEpisodeState();
}

class _DetailsPaneEpisodeState extends ConsumerState<EpisodeDetailsPane> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) {
        return ref.watch(currentEpisodeProvider).when(
          data: (Episode episode) {
            titleController.text = episode.getTitle;
            descriptionController.text = episode.getDescription;
            titleController.selection = TextSelection.collapsed(offset: titleController.text.length);
            descriptionController.selection = TextSelection.collapsed(offset: descriptionController.text.length);

            return Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Focus(
                    onFocusChange: (bool hasFocus) {
                      if (!hasFocus && titleController.text != project.title) {
                        edit(episode);
                      }
                    },
                    child: TextField(
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
                      controller: titleController,
                      maxLength: 64,
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 16)),
                  Focus(
                    onFocusChange: (bool hasFocus) {
                      if (!hasFocus && descriptionController.text != project.description) {
                        edit(episode);
                      }
                    },
                    child: TextField(
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: null,
                      maxLength: 280,
                    ),
                  ),
                ],
              ),
            );
          },
          error: (Object error, StackTrace stackTrace) {
            return requestPlaceholderError;
          },
          loading: () {
            return requestPlaceholderLoading;
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return requestPlaceholderError;
      },
      loading: () {
        return requestPlaceholderLoading;
      },
    );
  }

  void edit(Episode episode) {
    episode.title = titleController.text;
    episode.description = descriptionController.text;

    ref.read(episodesProvider.notifier).edit(episode);
    ref.read(currentEpisodeProvider.notifier).set(episode);
  }
}
