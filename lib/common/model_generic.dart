import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/utils/constants/constants.dart';

abstract class ModelGeneric<T extends BaseModel> {
  String get item {
    switch (T) {
      case const (Project):
        return localizations.item_project(1);
      case const (Episode):
        return localizations.item_episode(1);
      case const (Sequence):
        return localizations.item_sequence(1);
      case const (Shot):
        return localizations.item_shot(1);
      case const (Member):
        return localizations.item_member(1);
      case const (Location):
        return localizations.item_location(1);
      default:
        throw TypeError();
    }
  }

  Gender get gender {
    switch (T) {
      case const (Project):
        return Gender.male;
      case const (Episode):
        return Gender.male;
      case const (Sequence):
        return Gender.female;
      case const (Shot):
        return Gender.male;
      case const (Member):
        return Gender.male;
      case const (Location):
        return Gender.male;
      default:
        throw TypeError();
    }
  }

  bool get shouldPop {
    switch (T) {
      case const (Project):
        return false;
      case const (Episode):
        return true;
      case const (Sequence):
        return true;
      case const (Shot):
        return false;
      case const (Member):
        return false;
      case const (Location):
        return false;
      default:
        throw TypeError();
    }
  }
}
