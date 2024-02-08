import 'dart:async';
import 'dart:developer';

import 'package:cpm/models/location/location.dart';
import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locations.g.dart';

@riverpod
class Locations extends _$Locations with BaseProvider {
  final _table = SupabaseTable.location;

  @override
  FutureOr<List<Location>> build() {
    return get();
  }

  Future<List<Location>> get() async {
    state = const AsyncLoading<List<Location>>();

    if (await CacheManager().contains(CacheKey.locations)) {
      state = AsyncData<List<Location>>(
        await CacheManager().get<Location>(CacheKey.locations, Location.fromJson),
      );
    }

    final List<Location> locations = await selectLocationService.selectLocations();
    CacheManager().set(CacheKey.locations, locations);
    state = AsyncData<List<Location>>(locations);

    return locations;
  }

  Future<bool> add(Location newLocation) async {
    try {
      await insertService.insert(_table, newLocation);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Location editedLocation) async {
    try {
      await updateService.update(_table, editedLocation);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    state = AsyncData<List<Location>>(<Location>[
      for (final Location location in state.value ?? <Location>[])
        if (location.id != editedLocation.id) location else editedLocation,
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
    state = AsyncData<List<Location>>(<Location>[
      for (final Location location in state.value ?? <Location>[])
        if (location.id != id) location,
    ]);

    return true;
  }
}

@Riverpod(keepAlive: true)
class CurrentLocation extends _$CurrentLocation with BaseProvider {
  @override
  FutureOr<Location> build() {
    return Future.value(); // ignore: null_argument_to_non_null_type
  }

  void set(Location location) {
    state = AsyncData<Location>(location);
  }
}
