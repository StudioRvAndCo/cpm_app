import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/link/link.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/project/project_type.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:cpm/utils/extensions/file_extensions.dart';
import 'package:cpm/utils/extensions/string_extensions.dart';
import 'package:cpm/utils/lexo_ranker.dart';
import 'package:excel/excel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'projects.g.dart';

@riverpod
class Projects extends _$Projects with BaseProvider {
  final _table = SupabaseTable.project;
  final _cacheKey = CacheKey.projects;

  @override
  FutureOr<List<Project>> build() {
    return get();
  }

  Future<List<Project>> get([bool sortOnly = false]) async {
    List<Project> projects;
    if (sortOnly) {
      projects = (state.value ?? [])..sort();
    } else {
      state = const AsyncLoading<List<Project>>();

      if (await CacheManager().contains(_cacheKey)) {
        state = AsyncData<List<Project>>(
          await CacheManager().get<Project>(_cacheKey, Project.fromJson),
        );
      }

      projects = await selectProjectService.selectProjects()
        ..sort();
      CacheManager().set(_cacheKey, projects);
    }
    state = AsyncData<List<Project>>(projects);

    return projects;
  }

  Future<bool> add(Project newProject) async {
    try {
      if (newProject.isMovie) {
        final project = await insertService.insertAndReturn<Project>(_table, newProject, Project.fromJson);
        await insertService.insert(SupabaseTable.episode, Episode.moviePlaceholder(project.id));
      } else {
        await insertService.insert(_table, newProject);
      }
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    await get();

    return true;
  }

  Future<bool> import(ProjectType projectType, String filePath) async {
    try {
      final file = File(filePath);
      final excel = Excel.decodeBytes(file.readAsBytesSync());

      final newProject = Project(
        projectType: projectType,
        title: file.nameWithoutExtension,
        startDate: DateTime.now(),
        endDate: DateTime.now().weekLater,
      );
      final project = await insertService.insertAndReturn<Project>(_table, newProject, Project.fromJson);

      switch (projectType) {
        case ProjectType.movie:
          await _importMovie(project.id, excel);
        case ProjectType.series:
          await _importSeries(project.id, excel);
        default:
          throw Exception();
      }
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    await get();

    return true;
  }

  Future<void> _importMovie(int projectId, Excel excel) async {
    final episode = await insertService.insertAndReturn(
      SupabaseTable.episode,
      Episode.moviePlaceholder(projectId),
      Episode.fromJson,
    );

    String? previousSequenceLexoRank;
    excel.sheets.forEach((name, sheet) async {
      if (name.startsWith('_')) {
        return;
      }

      final sequenceLexoRank = LexoRanker().newRank(previous: previousSequenceLexoRank);
      previousSequenceLexoRank = sequenceLexoRank;
      final sequence = Sequence.parseExcel(
        episode.id,
        name,
        sheet.rows.first,
        sequenceLexoRank,
      );
      final sequenceId = await ref.read(sequencesProvider.notifier).import(sequence);

      if (sequenceId == -1) {
        throw Exception();
      }

      String? previousShotLexoRank;
      final shots = sheet.rows
          .where((row) {
            return row.any((data) {
              return data != null && data.value != null && data.value.toString().isNotBlank;
            });
          })
          .skip(2)
          .map((row) {
            final shotLexoRank = LexoRanker().newRank(previous: previousShotLexoRank);
            previousShotLexoRank = shotLexoRank;
            return Shot.parseExcel(
              sequenceId,
              row,
              shotLexoRank,
            );
          })
          .toList();

      await ref.read(shotsProvider.notifier).add(shots);
    });
  }

  Future<void> _importSeries(int projectId, Excel excel) async {
    throw UnimplementedError();
  }

  Future<bool> edit(Project editedProject) async {
    try {
      await updateService.update(_table, editedProject);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    state = AsyncData<List<Project>>(<Project>[
      for (final Project project in state.value ?? <Project>[])
        if (project.id != editedProject.id) project else editedProject,
    ]);

    return true;
  }

  Future<bool> delete(int? id) async {
    try {
      await deleteService.delete(_table, id);
    } catch (exception, stackTrace) {
      log(exception.toString(), stackTrace: stackTrace);
      return false;
    }
    state = AsyncData<List<Project>>(<Project>[
      for (final Project project in state.value ?? <Project>[])
        if (project.id != id) project,
    ]);

    return true;
  }
}

@Riverpod(keepAlive: true)
class CurrentProject extends _$CurrentProject with BaseProvider {
  final _linkTable = SupabaseTable.link;

  @override
  FutureOr<Project> build() {
    return Future.value(); // ignore: null_argument_to_non_null_type
  }

  Future<void> set(Project project) async {
    project.links = await selectLinkService.selectLinks(project.id);
    state = AsyncData<Project>(project);
  }

  Future<void> addLink(Link newLink) async {
    await insertService.insert(_linkTable, newLink);
    if (state.value != null) {
      await set(state.value!); // Get the new list of links
    }
  }

  Future<void> editLink(Link editedLink) async {
    await updateService.update(_linkTable, editedLink);
    if (state.value != null) {
      await set(state.value!); // Get the new list of links
    }
  }

  Future<void> deleteLink(int? id) async {
    await deleteService.delete(_linkTable, id);
    if (state.value != null) {
      await set(state.value!); // Get the new list of links
    }
  }
}
