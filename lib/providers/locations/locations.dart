import 'dart:async';

import 'package:cpm/models/location/location.dart';
import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locations.g.dart';

@riverpod
class Locations extends _$Locations with BaseProvider {
  final _table = SupabaseTable.location;

  @override
  FutureOr<List<Location>> build() {
    get();

    return <Location>[];
  }

  Future<void> get() async {
    state = const AsyncLoading<List<Location>>();
    final List<Location> locations = await selectLocationService.selectLocations();
    state = AsyncData<List<Location>>(locations);
  }

  Future<bool> add(Location newLocation) async {
    try {
      await insertService.insert(_table, newLocation);
    } catch (_) {
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Location editedLocation) async {
    try {
      await updateService.update(_table, editedLocation);
    } catch (_) {
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
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Location>>(<Location>[
      for (final Location location in state.value ?? <Location>[])
        if (location.id != id) location,
    ]);

    return true;
  }
}
