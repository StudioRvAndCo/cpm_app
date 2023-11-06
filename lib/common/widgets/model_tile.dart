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
    this.trailing,
    this.menuActions,
  });

  final Function() delete;

  final T model;
  final IconData leadingIcon;
  final ImageProvider? leadingImage;
  final String title;
  final String? subtitle;
  final List<Widget>? trailing;
  final List<MenuAction>? menuActions;

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

  void _onMenuSelected(MenuAction action) {
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
            ...?widget.trailing,
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<MenuAction>>[
                  ...?widget.menuActions?.map((action) => action.popupMenuItem),
                  if (widget.menuActions != null && widget.menuActions!.isNotEmpty) const PopupMenuDivider(),
                  MenuAction.edit.popupMenuItem,
                  MenuAction.delete.popupMenuItem,
                ];
              },
              onSelected: _onMenuSelected,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: Radiuses.radius8.circular),
        onTap: () => _showSheet(context),
      ),
    );
  }
}
