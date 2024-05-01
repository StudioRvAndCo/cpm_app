import 'package:cpm/common/model_generic.dart';
import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/models/project/project.dart';
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
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeleteAction<T extends BaseModel> extends ModelGeneric<T> {
  DeleteAction() {
    if (T == dynamic) {
      throw TypeError();
    }
  }

  Future<void> delete(
    BuildContext context,
    WidgetRef ref, {
    required int? id,
  }) async {
    if (T == dynamic) {
      throw TypeError();
    }
    if (id == null) {
      return;
    }

    await showAdaptiveDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localizations.dialog_delete_item_confirmation(item, gender.name)),
          content: Text(localizations.dialog_delete_cannot_be_undone),
          actions: <Widget>[
            TextButton(
              child: Text(localizations.button_cancel),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            ElevatedButton(
              autofocus: true,
              child: Text(localizations.button_delete),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    ).then((delete) async {
      if (delete == null) {
        return;
      }

      bool deleted = false;
      switch (T) {
        case const (Project):
          deleted = await ref.read(projectsProvider.notifier).delete(id);
        case const (Episode):
          deleted = await ref.read(episodesProvider.notifier).delete(id);
        case const (Sequence):
          deleted = await ref.read(sequencesProvider.notifier).delete(id);
        case const (Shot):
          deleted = await ref.read(shotsProvider.notifier).delete(id);
        case const (Member):
          deleted = await ref.read(membersProvider.notifier).delete(id);
        case const (Location):
          deleted = await ref.read(locationsProvider.notifier).delete(id);
      }

      if (deleted && shouldPop && context.mounted) {
        context.pop();
      }

      SnackBarManager.info(
        deleted
            ? localizations.snack_bar_delete_success_item(item, gender.name)
            : localizations.snack_bar_delete_fail_item(item, gender.name),
      ).show();
    });
  }
}
