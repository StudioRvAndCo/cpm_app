import 'package:cpm/utils/platform.dart';
import 'package:flutter/material.dart';

class SheetManager {
  void showSheet(BuildContext context, Widget sheet) {
    kIsMobile ? _showBottomSheet(context, sheet) : _showSideSheet(context, sheet);
  }

  void _showBottomSheet(BuildContext context, Widget sheet) {
    showModalBottomSheet(
      context: context,
      enableDrag: true,
      showDragHandle: true,
      isScrollControlled: true,
      clipBehavior: Clip.hardEdge,
      builder: (context) {
        return sheet;
      },
    );
  }

  // TODO implement when side sheet is implemented
  // https://github.com/flutter/flutter/issues/119328
  void _showSideSheet(BuildContext context, Widget sheet) {
    _showBottomSheet(context, sheet);
  }
}
