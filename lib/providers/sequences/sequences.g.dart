// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequences.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sequencesHash() => r'04e5ea84f0b9497f0445274081774aa23edcfc94';

/// See also [Sequences].
@ProviderFor(Sequences)
final sequencesProvider =
    AutoDisposeAsyncNotifierProvider<Sequences, List<Sequence>>.internal(
  Sequences.new,
  name: r'sequencesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$sequencesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Sequences = AutoDisposeAsyncNotifier<List<Sequence>>;
String _$currentSequenceHash() => r'dbd26f4baf421f684db15ed1658aedb9be11e82b';

/// See also [CurrentSequence].
@ProviderFor(CurrentSequence)
final currentSequenceProvider =
    AsyncNotifierProvider<CurrentSequence, Sequence>.internal(
  CurrentSequence.new,
  name: r'currentSequenceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentSequenceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentSequence = AsyncNotifier<Sequence>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member
