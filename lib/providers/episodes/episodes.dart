import 'dart:async';

import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/episode/episode.dart';
import '../../models/project/project.dart';
import '../projects/projects.dart';

part 'episodes.g.dart';

@riverpod
class Episodes extends _$Episodes with BaseProvider {
  SupabaseTable table = SupabaseTable.episode;

  @override
  FutureOr<List<Episode>> build() {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        final List<Episode> episodes = await selectEpisodeService.selectEpisodes(project.id);

        return episodes;
      },
      error: (Object error, StackTrace stackTrace) {
        return <Episode>[];
      },
      loading: () {
        return <Episode>[];
      },
    );
  }

  Future<void> get() {
    state = const AsyncLoading<List<Episode>>();

    return ref.watch(currentProjectProvider).when(
      data: (project) async {
        final List<Episode> episodes = await selectEpisodeService.selectEpisodes(project.id);
        state = AsyncData<List<Episode>>(episodes);

        if (project.isMovie) {
          ref.read(currentEpisodeProvider.notifier).set(episodes.first);
        }
      },
      error: (Object error, StackTrace stackTrace) {
        return Future.value();
      },
      loading: () {
        return Future.value();
      },
    );
  }

  Future<void> set(int projectId) async {
    final Episode episodes = await selectEpisodeService.selectFirstEpisode(projectId);
    ref.read(currentEpisodeProvider.notifier).set(episodes);
  }

  Future<void> add(Episode newEpisode) async {
    await insertService.insert(table, newEpisode);
    await get();
  }

  Future<void> edit(Episode editedEpisode) async {
    await updateService.update(table, editedEpisode);
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != editedEpisode.id) episode else editedEpisode,
    ]);
  }

  Future<void> delete(int? id) async {
    await deleteService.delete(table, id);
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != id) episode,
    ]);
  }
}

@Riverpod(keepAlive: true)
class CurrentEpisode extends _$CurrentEpisode {
  @override
  FutureOr<Episode> build() {
    return Future.value(null); // ignore: null_argument_to_non_null_type
  }

  void set(Episode episode) {
    state = AsyncData<Episode>(episode);
  }
}
