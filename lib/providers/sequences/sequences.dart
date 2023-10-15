import 'package:cpm/models/sequence_location/sequence_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/episode/episode.dart';
import '../../models/sequence/sequence.dart';
import '../../services/config/supabase_table.dart';
import '../base_provider.dart';
import '../episodes/episodes.dart';
import '../projects/projects.dart';

part 'sequences.g.dart';

@Riverpod(keepAlive: true)
class Sequences extends _$Sequences with BaseProvider {
  SupabaseTable table = SupabaseTable.sequence;

  @override
  FutureOr<List<Sequence>> build() {
    return ref.watch(currentEpisodeProvider).when(
      data: (Episode episode) async {
        return await selectSequenceService.selectSequences(episode.id);
      },
      error: (Object error, StackTrace stackTrace) {
        return <Sequence>[];
      },
      loading: () {
        return <Sequence>[];
      },
    );
  }

  Future<void> get() {
    state = const AsyncLoading<List<Sequence>>();

    return ref.watch(currentEpisodeProvider).when(
      data: (Episode episode) async {
        List<Sequence> sequences = await selectSequenceService.selectSequences(episode.id);
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

  Future<void> getAll() {
    state = const AsyncLoading<List<Sequence>>();

    return ref.watch(currentProjectProvider).when(
      data: (project) async {
        final episodes = await selectEpisodeService.selectEpisodes(project.id);
        final List<Sequence> sequences = [];

        for (final episode in episodes) {
          sequences.addAll(await selectSequenceService.selectSequences(episode.id));
        }

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

  Future<bool> add(Sequence newSequence, [int? locationId]) async {
    try {
      Sequence createdSequence = await insertService.insertAndReturn(table, newSequence, Sequence.fromJson);
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
      await updateService.update(table, editedSequence);
    } catch (_) {
      return false;
    }
    if (locationId != null) {
      SequenceLocation newSequenceLocation = SequenceLocation.insert(
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
      await deleteService.delete(table, id);
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
    SequenceLocation sequenceLocation = SequenceLocation.insert(sequence: sequenceId, location: locationId);
    await upsertService.upsert(SupabaseTable.sequenceLocation, sequenceLocation);
  }

  Future<void> _updateLocation(SequenceLocation sequenceLocation) async {
    await updateService.updateWhere(
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
    return Future.value(null); // ignore: null_argument_to_non_null_type
  }

  void set(Sequence sequence) {
    state = AsyncData<Sequence>(sequence);
  }
}
