import 'package:cpm/utils/constants/constants.dart';
import 'package:flutter/material.dart';

enum ProjectLinkAction {
  open(Icons.launch),
  moveUp(Icons.arrow_upward),
  moveDown(Icons.arrow_downward),
  delete(Icons.remove_circle),
  ;

  final IconData icon;

  const ProjectLinkAction(this.icon);

  String get title {
    switch (this) {
      case open:
        return localizations.menu_open;
      case moveUp:
        return localizations.menu_move_up;
      case moveDown:
        return localizations.menu_edit;
      case delete:
        return localizations.menu_delete;
    }
  }
}
