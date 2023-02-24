import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../models/location.dart';

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
              onPressed: () {
                MapsLauncher.launchQuery(widget.location.address);
              },
              icon: const Icon(Icons.map)),
          PopupMenuButton<MenuAction>(
            icon: const Icon(Icons.more_horiz),
            itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuAction>>[
              const PopupMenuItem<MenuAction>(
                  value: MenuAction.edit,
                  child: ListTile(
                    leading: Icon(Icons.edit),
                    title: Text('Edit'),
                  )),
              const PopupMenuItem<MenuAction>(
                  value: MenuAction.delete,
                  child: ListTile(
                    leading: Icon(Icons.delete),
                    title: Text('Delete'),
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
}
