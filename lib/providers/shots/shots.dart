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

  Future<bool> add(Shot newShot) async {
    try {
      await insertService.insert(table, newShot);
    } catch (_) {
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Shot editedShot) async {
    try {
      await updateService.update(table, editedShot);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot shot in state.value ?? <Shot>[])
        if (shot.id != editedShot.id) shot else editedShot,
    ]);

    return true;
  }

  Future<bool> toggleCompletion(Shot toToggleShot) async {
    toToggleShot.completed = !toToggleShot.completed;
    try {
      await updateService.update(table, toToggleShot);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot shot in state.value ?? <Shot>[])
        if (shot.id != toToggleShot.id) shot else toToggleShot,
    ]);

    return true;
  }

  Future<bool> delete(int id) async {
    try {
      await deleteService.delete(table, id);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot shot in state.value ?? <Shot>[])
        if (shot.id != id) shot,
    ]);

    return true;
  }
}

@Riverpod(keepAlive: true)
class CurrentShot extends _$CurrentShot {
  @override
  FutureOr<Shot> build() {
    return Future.value(null); // ignore: null_argument_to_non_null_type
  }

  void set(Shot shot) {
    state = AsyncData<Shot>(shot);
  }
}
