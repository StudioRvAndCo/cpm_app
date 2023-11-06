import 'dart:async';

import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'episodes.g.dart';

@riverpod
class Episodes extends _$Episodes with BaseProvider {
  final _table = SupabaseTable.episode;
  final _cacheKey = CacheKey.episodes;

  @override
  FutureOr<List<Episode>> build() {
    get();

    return <Episode>[];
  }

  Future<void> get() async {
    state = const AsyncLoading<List<Episode>>();

    ref.watch(currentProjectProvider).when(
          data: (project) async {
            if (await CacheManager().contains(_cacheKey, project.id)) {
              state = AsyncData<List<Episode>>(
                await CacheManager().get<Episode>(_cacheKey, Episode.fromJson, project.id),
              );
            }

            final List<Episode> episodes = await selectEpisodeService.selectEpisodes(project.id);
            CacheManager().set(_cacheKey, episodes, project.id);
            state = AsyncData<List<Episode>>(episodes);

            if (project.isMovie) {
              ref.read(currentEpisodeProvider.notifier).set(episodes.first);
            }
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {},
        );
  }

  Future<void> set(int projectId) async {
    final Episode episodes = await selectEpisodeService.selectFirstEpisode(projectId);
    ref.read(currentEpisodeProvider.notifier).set(episodes);
  }

  Future<bool> add(Episode newEpisode) async {
    try {
      await insertService.insert(_table, newEpisode);
    } catch (_) {
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Episode editedEpisode) async {
    try {
      await updateService.update(_table, editedEpisode);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != editedEpisode.id) episode else editedEpisode,
    ]);

    return true;
  }

  Future<bool> delete(int? id) async {
    try {
      await deleteService.delete(_table, id);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != id) episode,
    ]);

    return true;
  }
}

@Riverpod(keepAlive: true)
class CurrentEpisode extends _$CurrentEpisode {
  @override
  FutureOr<Episode> build() {
    return Future.value(); // ignore: null_argument_to_non_null_type
  }

  void set(Episode episode) {
    state = AsyncData<Episode>(episode);
  }
}
