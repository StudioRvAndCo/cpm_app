// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episodes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$episodesHash() => r'd3ccddb8c603e0ba07c212eae1eb2c5b6dd4a9e0';

/// See also [Episodes].
@ProviderFor(Episodes)
final episodesProvider = AutoDisposeAsyncNotifierProvider<Episodes, List<Episode>>.internal(
  Episodes.new,
  name: r'episodesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$episodesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Episodes = AutoDisposeAsyncNotifier<List<Episode>>;
String _$currentEpisodeHash() => r'19e7c7159cdb655c426391cecd0cc868a90f4f23';

/// See also [CurrentEpisode].
@ProviderFor(CurrentEpisode)
final currentEpisodeProvider = AsyncNotifierProvider<CurrentEpisode, Episode>.internal(
  CurrentEpisode.new,
  name: r'currentEpisodeProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$currentEpisodeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentEpisode = AsyncNotifier<Episode>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
