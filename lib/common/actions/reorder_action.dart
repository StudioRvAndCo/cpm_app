import 'package:cpm/common/model_generic.dart';
import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/link/link.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/lexo_ranker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReorderAction<Model extends BaseModel> extends ModelGeneric<Model> {
  ReorderAction() {
    if (Model == dynamic) {
      throw TypeError();
    }
  }

  Future<void> reorder(
    BuildContext context,
    WidgetRef ref, {
    required int oldIndex,
    required int newIndex,
    required List<Model> models,
  }) async {
    if (Model != Link && Model != Episode && Model != Sequence && Model != Shot) {
      throw TypeError();
    }

    Model? previousModel;
    Model? nextModel;
    if (newIndex == 0) {
      nextModel = models.first;
    } else if (newIndex == models.length) {
      previousModel = models.last;
    } else {
      previousModel = models[newIndex - 1];
      nextModel = models[newIndex];
    }

    final reorderedModel = models[oldIndex];
    final newLexoIndex = LexoRanker().newRank(previous: previousModel?.index, next: nextModel?.index);

    switch (Model) {
      case const (Episode):
        (reorderedModel as Episode).index = newLexoIndex;
        await ref.read(episodesProvider.notifier).edit(reorderedModel);
      case const (Sequence):
        (reorderedModel as Sequence).index = newLexoIndex;
        await ref.read(sequencesProvider.notifier).edit(reorderedModel);
      case const (Shot):
        (reorderedModel as Shot).index = newLexoIndex;
        await ref.read(shotsProvider.notifier).edit(reorderedModel);
      default:
        throw TypeError();
    }
  }
}
