import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../dialogs/confirm_dialog.dart';
import '../dialogs/new_edit_location.dart';
import '../exceptions/invalid_direction_exception.dart';
import '../models/location.dart';
import '../services/location.dart';
import '../widgets/request_placeholder.dart';
import '../widgets/tiles/location_tile.dart';

class Locations extends StatefulWidget {
  const Locations({super.key});

  @override
  State<Locations> createState() => _LocationsState();
}

class _LocationsState extends State<Locations> {
  bool requestCompleted = false;
  late bool requestSucceeded;
  List<Location> locations = <Location>[];

  final Divider divider = const Divider(
    thickness: 1,
    color: Colors.grey,
    indent: 16,
    endIndent: 16,
    height: 0,
  );

  @override
  void initState() {
    getLocations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!requestCompleted) {
      return const RequestPlaceholder(placeholder: CircularProgressIndicator());
    } else if (requestSucceeded) {
      if (locations.isEmpty) {
        return RequestPlaceholder(placeholder: Text('locations.no_locations'.tr()));
      } else {
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
    } else {
      return RequestPlaceholder(placeholder: Text('errors.request_failed'.tr()));
    }
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
            // TODO(mael): add member via API
          });
        }
      },
    );
  }

  Future<void> getLocations() async {
    final List<dynamic> result = await LocationService().getLocations();
    setState(() {
      requestCompleted = true;
      requestSucceeded = result[0] as bool;
      locations = result[1] as List<Location>;
    });
  }
}
