import 'package:flutter/material.dart';

import '../dialogs/confirm_dialog.dart';
import '../exceptions/invalid_direction_exception.dart';
import '../models/location.dart';
import '../widgets/location_tile.dart';

class Locations extends StatefulWidget {
  const Locations({super.key, required this.locations});

  final List<Location> locations;

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  final Divider divider = const Divider(
    thickness: 1,
    color: Colors.grey,
    indent: 16,
    endIndent: 16,
    height: 0,
  );

  @override
  Widget build(BuildContext context) {
    final Iterable<LocationTile> locationsTiles = widget.locations.map((Location location) => LocationTile(
          location: location,
          onEdit: (Location location) {
            edit(location);
          },
          onDelete: (Location location) {
            showConfirmationDialog(context, 'delete').then((bool? result) {
              if (result ?? false) {
                delete(location);
              }
            });
          },
        ));

    return Expanded(
        child: ListView.separated(
      separatorBuilder: (BuildContext context, int index) => divider,
      itemCount: locationsTiles.length,
      itemBuilder: (BuildContext context, int index) => ClipRRect(
        clipBehavior: Clip.hardEdge,
        child: Dismissible(
          key: UniqueKey(),
          onDismissed: (DismissDirection direction) {
            final Location location = locationsTiles.elementAt(index).location;
            switch (direction) {
              case DismissDirection.endToStart:
                edit(location);
                break;
              case DismissDirection.startToEnd:
                delete(location);
                break;
              case DismissDirection.vertical:
              case DismissDirection.horizontal:
              case DismissDirection.up:
              case DismissDirection.down:
              case DismissDirection.none:
                throw InvalidDirectionException('Invalid direction');
            }
          },
          confirmDismiss: (DismissDirection dismissDirection) async {
            switch (dismissDirection) {
              case DismissDirection.endToStart:
                return true;
              case DismissDirection.startToEnd:
                return await showConfirmationDialog(context, 'delete') ?? false == true;
              case DismissDirection.horizontal:
              case DismissDirection.vertical:
              case DismissDirection.up:
              case DismissDirection.down:
              case DismissDirection.none:
                assert(false);
            }
            return false;
          },
          background: deleteBackground(),
          secondaryBackground: editBackground(),
          child: locationsTiles.elementAt(index),
        ),
      ),
    ));
  }

  void edit(Location location) {
    setState(() {
      print('edit $location');
    });
  }

  void delete(Location location) {
    setState(() {
      widget.locations.remove(location);
    });
  }
}
