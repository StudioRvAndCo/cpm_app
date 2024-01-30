import 'dart:developer';

import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'sequences.g.dart';

@Riverpod(keepAlive: true)
class Sequences extends _$Sequences with BaseProvider {
  final _table = SupabaseTable.sequence;
  final _cacheKey = CacheKey.sequences;

  @override
  FutureOr<List<Sequence>> build() {
    get();

    return <Sequence>[];
  }

  Future<void> get() async {
    state = const AsyncLoading<List<Sequence>>();

    ref.watch(currentEpisodeProvider).when(
      data: (episode) async {
        if (await CacheManager().contains(_cacheKey, episode.id)) {
          state = AsyncData<List<Sequence>>(
            await CacheManager().get<Sequence>(_cacheKey, Sequence.fromJson, episode.id),
          );
        }

        final List<Sequence> sequences = await selectSequenceService.selectSequences(episode.id);
        CacheManager().set(_cacheKey, sequences, episode.id);
        state = AsyncData<List<Sequence>>(sequences);
      },
      error: (Object error, StackTrace stackTrace) {
        return Future.value();
      },
      loading: () {
        return Future.value();
      },
    );
  }

  Future<void> getAll() async {
    state = const AsyncLoading<List<Sequence>>();

    ref.watch(currentProjectProvider).when(
          data: (project) async {
            final episodes = await selectEpisodeService.selectEpisodes(project.id);
            final List<Sequence> sequences = [];

            for (final episode in episodes) {
              sequences.addAll(await selectSequenceService.selectSequences(episode.id));
            }

            state = AsyncData<List<Sequence>>(sequences);
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {},
        );
  }

  Future<bool> add(Sequence newSequence) async {
    try {
      await insertService.insert(_table, newSequence);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    await get();

    return true;
  }

  Future<int> import(Sequence importedSequence) async {
    try {
      final sequence = await insertService.insertAndReturn(_table, importedSequence, Sequence.fromJson);
      return sequence.id;
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return -1;
    }
  }

  Future<bool> edit(Sequence editedSequence) async {
    try {
      await updateService.update(_table, editedSequence);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    state = AsyncData<List<Sequence>>(<Sequence>[
      for (final Sequence sequence in state.value ?? <Sequence>[])
        if (sequence.id != editedSequence.id) sequence else editedSequence,
    ]);

    return true;
  }

  Future<bool> delete(int? id) async {
    try {
      await deleteService.delete(_table, id);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    state = AsyncData<List<Sequence>>(<Sequence>[
      for (final Sequence sequence in state.value ?? <Sequence>[])
        if (sequence.id != id) sequence,
    ]);

    return true;
  }
}

@Riverpod(keepAlive: true)
class CurrentSequence extends _$CurrentSequence {
  @override
  FutureOr<Sequence> build() {
    return Future.value(); // ignore: null_argument_to_non_null_type
  }

  void set(Sequence sequence) {
    state = AsyncData<Sequence>(sequence);
  }
}
