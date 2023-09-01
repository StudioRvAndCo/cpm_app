import 'package:cpm/models/sequence_location/sequence_location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/episode/episode.dart';
import '../../models/sequence/sequence.dart';
import '../../services/config/supabase_table.dart';
import '../base_provider.dart';
import '../episodes/episodes.dart';

part 'sequences.g.dart';

@riverpod
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

  Future<void> add(Sequence newSequence, [int? locationId]) async {
    Sequence createdSequence = await insertService.insertAndReturn(table, newSequence, Sequence.fromJson);
    if (locationId != null) {
      await _setLocation(createdSequence.id, locationId);
    }
    await get();
  }

  Future<void> edit(Sequence editedSequence, int? locationId) async {
    await updateService.update(table, editedSequence);
    if (locationId != null) {
      SequenceLocation newSequenceLocation = SequenceLocation.insert(
        sequence: editedSequence.id,
        location: locationId,
      );
      await _updateLocation(newSequenceLocation);
    } else {
      state = AsyncData<List<Sequence>>(<Sequence>[
        for (final Sequence sequence in state.value ?? <Sequence>[])
          if (sequence.id != editedSequence.id) sequence else editedSequence,
      ]);
    }
  }

  Future<void> delete(int? id) async {
    await deleteService.delete(table, id);
    state = AsyncData<List<Sequence>>(<Sequence>[
      for (final Sequence sequence in state.value ?? <Sequence>[])
        if (sequence.id != id) sequence,
    ]);
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
