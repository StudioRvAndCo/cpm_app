// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shots.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$shotsHash() => r'64fa328d3f0f34dd284ebbb34e829c1b8be3cf56';

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
String _$currentShotHash() => r'45039fc356017c5eb0883a4b9e7f8cb1e01bfbaf';

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
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
