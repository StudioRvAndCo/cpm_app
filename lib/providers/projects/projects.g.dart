// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'cc863fc7730f025d8c6785d67aff5fa0012d3b08';

/// See also [Projects].
@ProviderFor(Projects)
final projectsProvider = AutoDisposeAsyncNotifierProvider<Projects, List<Project>>.internal(
  Projects.new,
  name: r'projectsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$projectsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Projects = AutoDisposeAsyncNotifier<List<Project>>;
String _$currentProjectHash() => r'44fdebb108d38a99240b4e552fde99e760d128b0';

/// See also [CurrentProject].
@ProviderFor(CurrentProject)
final currentProjectProvider = AsyncNotifierProvider<CurrentProject, Project>.internal(
  CurrentProject.new,
  name: r'currentProjectProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$currentProjectHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentProject = AsyncNotifier<Project>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
