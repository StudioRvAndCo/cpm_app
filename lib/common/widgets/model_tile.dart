import 'dart:math';

import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/common/sheets/location_sheet.dart';
import 'package:cpm/common/sheets/member_sheet.dart';
import 'package:cpm/common/sheets/sheet.dart';
import 'package:cpm/common/sheets/sheet_manager.dart';
import 'package:cpm/common/widgets/icon_image_provider.dart';
import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/utils/constants/radiuses.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ModelTile<T extends BaseModel> extends ConsumerStatefulWidget {
  const ModelTile({
    super.key,
    required this.model,
    required this.delete,
    required this.leadingIcon,
    this.leadingImage,
    required this.title,
    this.subtitle,
    this.actions,
  });

  final Function() delete;

  final T model;
  final IconData leadingIcon;
  final ImageProvider? leadingImage;
  final String title;
  final String? subtitle;
  final List<MenuAction>? actions;

  @override
  ConsumerState<ModelTile> createState() => _InfoTileState<T>();
}

class _InfoTileState<T extends BaseModel> extends ConsumerState<ModelTile> {
  void _showSheet(BuildContext context) {
    Widget sheet;

    switch (T) {
      case const (Member):
        ref.read(currentMemberProvider.notifier).set(widget.model as Member);
        sheet = Sheet(tabs: const [MemberSheet()]);
      case const (Location):
        ref.read(currentLocationProvider.notifier).set(widget.model as Location);
        sheet = Sheet(tabs: const [LocationSheet()]);
      default:
        throw Exception();
    }

    SheetManager().showSheet(context, sheet);
  }

  void _onActionSelected(MenuAction action) {
    switch (action) {
      case MenuAction.edit:
        _showSheet(context);
      case MenuAction.delete:
        widget.delete();
      case MenuAction.call:
        action.function!((widget.model as Member).phone!);
      case MenuAction.message:
        action.function!((widget.model as Member).phone!);
      case MenuAction.email:
        action.function!((widget.model as Member).email!);
      case MenuAction.map:
        action.function!((widget.model as Location).position!);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<MenuAction> primaryActions = [];
    List<MenuAction> secondaryActions = [];
    if (widget.actions != null && widget.actions!.isNotEmpty) {
      final isMobile = PlatformManager().isMobile;
      final nbActions = widget.actions!.length;
      primaryActions = widget.actions!.sublist(0, isMobile ? 0 : min(nbActions, 3));
      secondaryActions = widget.actions!.sublist(isMobile ? 1 : min(nbActions, 3));
    }
    secondaryActions.addAll(MenuAction.defaults);

    return Material(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: IconImageProvider(widget.leadingIcon),
          foregroundImage: widget.leadingImage,
        ),
        title: Text(
          widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: widget.subtitle != null && widget.subtitle!.isNotEmpty
            ? Text(
                widget.subtitle!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...primaryActions.map((action) {
              return IconButton(
                icon: Icon(action.icon),
                onPressed: () => _onActionSelected(action),
              );
            }),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return secondaryActions.map((action) {
                  return action.popupMenuItem;
                }).toList();
              },
              onSelected: _onActionSelected,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: Radiuses.radius8.circular),
        onTap: () => _showSheet(context),
      ),
    );
  }
}
