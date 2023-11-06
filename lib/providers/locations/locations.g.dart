// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationsHash() => r'7ebb6853fa41c0b62876a8d212dc68e43718e301';

/// See also [Locations].
@ProviderFor(Locations)
final locationsProvider = AutoDisposeAsyncNotifierProvider<Locations, List<Location>>.internal(
  Locations.new,
  name: r'locationsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$locationsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Locations = AutoDisposeAsyncNotifier<List<Location>>;
String _$currentLocationHash() => r'f957567221f933b6e65020b319854f7aec845710';

/// See also [CurrentLocation].
@ProviderFor(CurrentLocation)
final currentLocationProvider = AsyncNotifierProvider<CurrentLocation, Location>.internal(
  CurrentLocation.new,
  name: r'currentLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$currentLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentLocation = AsyncNotifier<Location>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
