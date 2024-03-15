import 'package:cpm/common/dialogs/add/add_episode_dialog.dart';
import 'package:cpm/common/dialogs/add/add_location_dialog.dart';
import 'package:cpm/common/dialogs/add/add_member_dialog.dart';
import 'package:cpm/common/dialogs/add/add_project_dialog.dart';
import 'package:cpm/common/dialogs/add/add_sequence_dialog.dart';
import 'package:cpm/common/dialogs/add/add_shot_dialog.dart';
import 'package:cpm/common/model_generic.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/project/project_type.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/snack_bar_manager.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddAction<Model extends BaseModel> extends ModelGeneric<Model> {
  Future<void> add(
    BuildContext context,
    WidgetRef ref, {
    int? parentId,
    String? index,
  }) async {
    if (Model != Project && Model != Episode && Model != Sequence && Model != Shot) throw TypeError();

    await showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        switch (Model) {
          case const (Project):
            return const AddProjectDialog();
          case const (Episode):
            if (parentId == null) throw ArgumentError('Project parent ID is required');
            if (index == null) throw ArgumentError('Index is required');

            return AddEpisodeDialog(projectId: parentId, index: index);
          case const (Sequence):
            if (parentId == null) throw ArgumentError('Episode parent ID is required');
            if (index == null) throw ArgumentError('Index is required');

            return AddSequenceDialog(episodeId: parentId, index: index);
          case const (Shot):
            if (parentId == null) throw ArgumentError('Sequence parent ID is required');
            if (index == null) throw ArgumentError('Index is required');

            return AddShotDialog(sequenceId: parentId, index: index);
          case const (Member):
            return const AddMemberDialog();
          case const (Location):
            return const AddLocationDialog();
          default:
            throw Exception();
        }
      },
    ).then((element) async {
      if (element == null) return;

      bool added = false;
      switch (Model) {
        case const (Project):
          added = await ref.read(projectsProvider.notifier).add(element as Project);
        case const (Episode):
          added = await ref.read(episodesProvider.notifier).add(element as Episode);
        case const (Sequence):
          added = await ref.read(sequencesProvider.notifier).add(element as Sequence);
        case const (Shot):
          added = await ref.read(shotsProvider.notifier).add(element as Shot);
        case const (Member):
          added = await ref.read(membersProvider.notifier).add(element as Member);
        case const (Location):
          added = await ref.read(locationsProvider.notifier).add(element as Location);
      }

      SnackBarManager.info(
        added
            ? localizations.snack_bar_add_success_item(item, gender.name)
            : localizations.snack_bar_add_fail_item(item, gender.name),
      ).show();
    });
  }

  Future<void> import(BuildContext context, WidgetRef ref) async {
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
    );

    if (file == null || !file.paths.first!.endsWith('xlsx')) return;

    SnackBarManager.info(localizations.snack_bar_import_item(localizations.item_project(1), Gender.male.name)).show();

    final added = await ref.read(projectsProvider.notifier).import(ProjectType.movie, file.paths.first!);

    SnackBarManager.info(
      added
          ? localizations.snack_bar_add_success_item(item, gender.name)
          : localizations.snack_bar_add_fail_item(item, gender.name),
    ).show();
  }
}
