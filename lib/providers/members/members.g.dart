// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'members.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$membersHash() => r'fc97740ba79ac92d23c9dd0341a5e814f58d0cbd';

/// See also [Members].
@ProviderFor(Members)
final membersProvider = AutoDisposeAsyncNotifierProvider<Members, List<Member>>.internal(
  Members.new,
  name: r'membersProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$membersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Members = AutoDisposeAsyncNotifier<List<Member>>;
String _$currentMemberHash() => r'84a7eb00fe03bf66d925aaa6b4dc1a5e81a73387';

/// See also [CurrentMember].
@ProviderFor(CurrentMember)
final currentMemberProvider = AsyncNotifierProvider<CurrentMember, Member>.internal(
  CurrentMember.new,
  name: r'currentMemberProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$currentMemberHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentMember = AsyncNotifier<Member>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
