import 'package:cpm/l10n/gender.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

enum EmptyPlaceholder {
  projects(Icons.movie),
  episodes(Icons.movie),
  sequences(Icons.movie),
  shots(Icons.movie),
  members(Icons.group),
  locations(Icons.map),
  ;

  final IconData icon;

  String get label {
    switch (this) {
      case EmptyPlaceholder.projects:
        return localizations.placeholder_empty(
          localizations.item_project(0),
          Gender.male.name,
        );
      case EmptyPlaceholder.episodes:
        return localizations.placeholder_empty(
          localizations.item_episode(0),
          Gender.male.name,
        );
      case EmptyPlaceholder.sequences:
        return localizations.placeholder_empty(
          localizations.item_sequence(0),
          Gender.female.name,
        );
      case EmptyPlaceholder.shots:
        return localizations.placeholder_empty(
          localizations.item_shot(0),
          Gender.male.name,
        );
      case EmptyPlaceholder.members:
        return localizations.placeholder_empty(
          localizations.item_member(0),
          Gender.male.name,
        );
      case EmptyPlaceholder.locations:
        return localizations.placeholder_empty(
          localizations.item_location(0),
          Gender.male.name,
        );
      default:
        throw Error();
    }
  }

  const EmptyPlaceholder(this.icon);
}
