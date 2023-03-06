import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../dialogs/confirm_dialog.dart';
import '../dialogs/new_edit_location.dart';
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
  late final List<Location> locations;

  final Divider divider = const Divider(
    thickness: 1,
    color: Colors.grey,
    indent: 16,
    endIndent: 16,
    height: 0,
  );

  @override
  void initState() {
    locations = widget.locations;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<LocationTile> locationsTiles = locations.map((Location location) => LocationTile(
          location: location,
          onEdit: (Location location) {
            edit(location);
          },
          onDelete: (Location location) {
            showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) {
              if (result ?? false) {
                delete(location);
              }
            });
          },
        ));

    return Expanded(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: add, child: const Icon(Icons.add)),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => divider,
        itemCount: locationsTiles.length,
        itemBuilder: (BuildContext context, int index) => ClipRRect(
          clipBehavior: Clip.hardEdge,
          child: Dismissible(
            key: UniqueKey(),
            onDismissed: (DismissDirection direction) {
              final Location location = locationsTiles.elementAt(index).location;
              switch (direction) {
                case DismissDirection.startToEnd:
                  delete(location);
                  break;
                case DismissDirection.endToStart:
                case DismissDirection.vertical:
                case DismissDirection.horizontal:
                case DismissDirection.up:
                case DismissDirection.down:
                case DismissDirection.none:
                  throw InvalidDirectionException('error.direction'.tr());
              }
            },
            confirmDismiss: (DismissDirection dismissDirection) async {
              switch (dismissDirection) {
                case DismissDirection.endToStart:
                  final Location location = locationsTiles.elementAt(index).location;
                  edit(location);
                  return false;
                case DismissDirection.startToEnd:
                  return await showConfirmationDialog(context, 'delete.lower'.tr()) ?? false == true;
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
      ),
    ));
  }

  void edit(Location location) {
    showDialog<Location>(
        context: context,
        builder: (BuildContext context) {
          return LocationDialog(
            edit: true,
            name: location.name,
            position: location.position,
          );
        }).then(
      (Location? result) {
        if (result != null) {
          setState(() {
            location.name = result.name;
            location.position = result.position;
          });
        }
      },
    );
  }

  void delete(Location location) {
    setState(() {
      locations.remove(location);
    });
  }

  void add() {
    showDialog<Location>(
        context: context,
        builder: (BuildContext context) {
          return const LocationDialog(
            edit: false,
          );
        }).then(
      (Location? result) {
        if (result != null) {
          setState(() {
            final Location location = Location(name: result.name, position: result.position);
            locations.add(location);
          });
        }
      },
    );
  }
}
