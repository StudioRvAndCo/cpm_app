import 'dart:developer';

import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shots.g.dart';

@riverpod
class Shots extends _$Shots with BaseProvider {
  final _table = SupabaseTable.shot;
  final _cacheKey = CacheKey.shots;

  @override
  FutureOr<List<Shot>> build() {
    return get();
  }

  Future<List<Shot>> get({bool refreshing = false}) async {
    if (!refreshing) {
      state = const AsyncLoading<List<Shot>>();
    }

    List<Shot> shots = [];
    ref.watch(currentSequenceProvider).when(
          data: (sequence) async {
            if (!refreshing && await CacheManager().contains(_cacheKey, sequence.id)) {
              state = AsyncData<List<Shot>>(
                await CacheManager().get<Shot>(_cacheKey, Shot.fromJson, sequence.id),
              );
            }

            shots = await selectShotService.selectShots(sequence.id);
            CacheManager().set(_cacheKey, shots, sequence.id);
            state = AsyncData<List<Shot>>(shots);
          },
          error: (Object error, StackTrace stackTrace) {},
          loading: () {},
        );

    return shots;
  }

  Future<bool> add(dynamic newShots) async {
    try {
      await insertService.insert(_table, newShots);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Shot editedShot) async {
    state = AsyncData<List<Shot>>(
      <Shot>[
        for (final Shot shot in state.value ?? <Shot>[])
          if (shot.id != editedShot.id) shot else editedShot,
      ]..sort((s1, s2) => s1.compareIndexes(s2.index)),
    );

    try {
      await updateService.update(_table, editedShot);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }

    return true;
  }

  Future<bool> toggleCompletion(Shot toToggleShot) async {
    toToggleShot.completed = !toToggleShot.completed;
    try {
      await updateService.update(_table, toToggleShot);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
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
      await deleteService.delete(_table, id);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
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
    return Future.value(); // ignore: null_argument_to_non_null_type
  }

  void set(Shot shot) {
    state = AsyncData<Shot>(shot);
  }
}
