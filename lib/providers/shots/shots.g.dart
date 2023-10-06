// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shots.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shotsHash() => r'e03f512c94f28cc4faa3d15202d173d99db86a62';

/// See also [Shots].
@ProviderFor(Shots)
final shotsProvider = AutoDisposeAsyncNotifierProvider<Shots, List<Shot>>.internal(
  Shots.new,
  name: r'shotsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$shotsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Shots = AutoDisposeAsyncNotifier<List<Shot>>;
String _$currentShotHash() => r'55785090a27b839a314b591ccef4e4ecb6c4b5c0';

/// See also [CurrentShot].
@ProviderFor(CurrentShot)
final currentShotProvider = AsyncNotifierProvider<CurrentShot, Shot>.internal(
  CurrentShot.new,
  name: r'currentShotProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$currentShotHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentShot = AsyncNotifier<Shot>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
