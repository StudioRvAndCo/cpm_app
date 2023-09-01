import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/sequence/sequence.dart';
import '../../models/shot/shot.dart';
import '../sequences/sequences.dart';

part 'shots.g.dart';

@riverpod
class Shots extends _$Shots with BaseProvider {
  SupabaseTable table = SupabaseTable.shot;

  @override
  FutureOr<List<Shot>> build() {
    return ref.watch(currentSequenceProvider).when(
      data: (Sequence sequence) async {
        return await selectShotService.selectShots(sequence.id);
      },
      error: (Object error, StackTrace stackTrace) {
        return <Shot>[];
      },
      loading: () {
        return <Shot>[];
      },
    );
  }

  Future<void> get() {
    state = const AsyncLoading<List<Shot>>();

    return ref.watch(currentSequenceProvider).when(
      data: (Sequence sequence) async {
        List<Shot> shots = await selectShotService.selectShots(sequence.id);
        state = AsyncData<List<Shot>>(shots);
      },
      error: (Object error, StackTrace stackTrace) {
        return Future.value();
      },
      loading: () {
        return Future.value();
      },
    );
  }

  Future<void> add(Shot newShot) async {
    await insertService.insert(table, newShot);
    await get();
  }

  Future<void> edit(Shot editedShot) async {
    await updateService.update(table, editedShot);
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot episode in state.value ?? <Shot>[])
        if (episode.id != editedShot.id) episode else editedShot,
    ]);
  }

  Future<void> delete(int id) async {
    await deleteService.delete(table, id);
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot episode in state.value ?? <Shot>[])
        if (episode.id != id) episode,
    ]);
  }
}
