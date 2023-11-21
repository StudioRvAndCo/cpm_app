import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EpisodeDetailsTab extends ConsumerStatefulWidget {
  const EpisodeDetailsTab({super.key});

  @override
  ConsumerState<EpisodeDetailsTab> createState() => _ProjectDetailsTabState();
}

class _ProjectDetailsTabState extends ConsumerState<EpisodeDetailsTab> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();

    final episode = ref.read(currentEpisodeProvider).value;
    title.text = episode?.title ?? '';
    description.text = episode?.description ?? '';
  }

  void _onSubmitted(Episode episode) {
    if (title.text == episode.title && description.text == episode.description) return;

    _edit(episode);
  }

  void _edit(Episode episode) {
    episode.title = title.text;
    episode.description = description.text;

    ref.read(episodesProvider.notifier).edit(episode);
    ref.read(currentEpisodeProvider.notifier).set(episode);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentEpisodeProvider).when(
      data: (episode) {
        return Column(
          children: [
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(episode) : null,
              child: TextField(
                controller: title,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_title,
                ),
                onSubmitted: (_) => _onSubmitted(episode),
              ),
            ),
            Padding(padding: Paddings.padding8.vertical),
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(episode) : null,
              child: TextField(
                controller: description,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_description,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
                onSubmitted: (_) => _onSubmitted(episode),
              ),
            ),
          ],
        );
      },
      loading: () {
        return CustomPlaceholder.loading();
      },
      error: (Object error, StackTrace stackTrace) {
        return CustomPlaceholder.error();
      },
    );
  }
}
