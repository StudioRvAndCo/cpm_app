import 'dart:async';

import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/location/location.dart';

part 'locations.g.dart';

@riverpod
class Locations extends _$Locations with BaseProvider {
  SupabaseTable table = SupabaseTable.location;

  @override
  FutureOr<List<Location>> build() {
    get();

    return <Location>[];
  }

  Future<void> get() async {
    state = const AsyncLoading<List<Location>>();
    List<Location> locations = await selectLocationService.selectLocations();
    state = AsyncData<List<Location>>(locations);
  }

  Future<void> add(Location newLocation) async {
    await insertService.insert(table, newLocation);
    await get(); // Get the locations in order to get the new location's ID
  }

  Future<void> edit(Location editedLocation) async {
    await updateService.update(table, editedLocation);
    state = AsyncData<List<Location>>(<Location>[
      for (final Location location in state.value ?? <Location>[])
        if (location.id != editedLocation.id) location else editedLocation,
    ]);
  }

  Future<void> delete(int id) async {
    await deleteService.delete(table, id);
    state = AsyncData<List<Location>>(<Location>[
      for (final Location location in state.value ?? <Location>[])
        if (location.id != id) location,
    ]);
  }
}
