import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/models/location/location.dart';
import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';

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
        widget.location.getName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            tooltip: 'locations.view',
            color: Theme.of(context).colorScheme.onBackground,
            onPressed: checkPosition()
                ? () {
                    MapsLauncher.launchQuery(widget.location.position!);
                  }
                : null,
            icon: const Icon(Icons.map),
          ),
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
                  title: Text('edit.upper'),
                ),
              ),
              PopupMenuItem<MenuAction>(
                value: MenuAction.delete,
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text('delete.upper'),
                ),
              ),
            ],
            onSelected: (MenuAction action) {
              setState(() {
                switch (action) {
                  case MenuAction.edit:
                    widget.onEdit(widget.location);
                  case MenuAction.delete:
                    widget.onDelete(widget.location);
                }
              });
            },
          ),
        ],
      ),
    );
  }

  bool checkPosition() {
    final String? position = widget.location.position;

    return position != null && position.isNotEmpty;
  }
}
