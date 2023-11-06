import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/sequence_location/sequence_location.dart';
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

  Future<bool> add(Sequence newSequence, [int? locationId]) async {
    try {
      final Sequence createdSequence = await insertService.insertAndReturn(_table, newSequence, Sequence.fromJson);
      if (locationId != null) {
        await _setLocation(createdSequence.id, locationId);
      }
    } catch (_) {
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Sequence editedSequence, int? locationId) async {
    try {
      await updateService.update(_table, editedSequence);
    } catch (_) {
      return false;
    }
    if (locationId != null) {
      final SequenceLocation newSequenceLocation = SequenceLocation.insert(
        sequence: editedSequence.id,
        location: locationId,
      );
      try {
        await _updateLocation(newSequenceLocation);
      } catch (_) {
        return false;
      }
    } else {
      state = AsyncData<List<Sequence>>(<Sequence>[
        for (final Sequence sequence in state.value ?? <Sequence>[])
          if (sequence.id != editedSequence.id) sequence else editedSequence,
      ]);
    }

    return true;
  }

  Future<bool> delete(int? id) async {
    try {
      await deleteService.delete(_table, id);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Sequence>>(<Sequence>[
      for (final Sequence sequence in state.value ?? <Sequence>[])
        if (sequence.id != id) sequence,
    ]);

    return true;
  }

  Future<void> _setLocation(int sequenceId, int locationId) async {
    final SequenceLocation sequenceLocation = SequenceLocation.insert(sequence: sequenceId, location: locationId);
    await upsertService.upsert(SupabaseTable.sequenceLocation, sequenceLocation);
  }

  Future<void> _updateLocation(SequenceLocation sequenceLocation) async {
    await updateService.updateOrInsert(
      SupabaseTable.sequenceLocation,
      sequenceLocation,
      'sequence',
      sequenceLocation.sequence.toString(),
    );
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
