// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$projectsHash() => r'db4733ead3ab3332a844d6ead03db25d24399a78';

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
String _$currentProjectHash() => r'39586ae366eb02dd65de62cc59c27856fa02e24a';

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
