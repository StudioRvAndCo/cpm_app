import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../../models/location.dart';

enum MenuAction { edit, delete }

class LocationTile extends StatefulWidget {
  const LocationTile({super.key, required this.location, required this.onEdit, required this.onDelete});

  final Location location;

  final Function(Location) onEdit;
  final Function(Location) onDelete;

  @override
  State<LocationTile> createState() => _LocationTileState();
}

class _LocationTileState extends State<LocationTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.location.name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
              tooltip: 'locations.view'.tr(),
              color: Theme.of(context).colorScheme.onBackground,
              onPressed: checkPosition()
                  ? () {
                      MapsLauncher.launchQuery(widget.location.position!);
                    }
                  : null,
              icon: const Icon(Icons.map)),
          PopupMenuButton<MenuAction>(
            icon: Icon(
              Icons.more_horiz,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
              PopupMenuItem<MenuAction>(
                  value: MenuAction.edit,
                  child: ListTile(
                    leading: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    title: Text('edit.upper'.tr()),
                  )),
              PopupMenuItem<MenuAction>(
                  value: MenuAction.delete,
                  child: ListTile(
                    leading: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    title: Text('delete.upper'.tr()),
                  )),
            ],
            onSelected: (MenuAction action) {
              setState(() {
                switch (action) {
                  case MenuAction.edit:
                    widget.onEdit(widget.location);
                    break;
                  case MenuAction.delete:
                    widget.onDelete(widget.location);
                    break;
                }
              });
            },
          )
        ],
      ),
    );
  }

  bool checkPosition() {
    return widget.location.position != null && widget.location.position != '';
  }
}
