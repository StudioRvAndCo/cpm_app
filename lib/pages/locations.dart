import 'package:cpm/widgets/snack_bars.dart';
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
      return const Expanded(child: RequestPlaceholder(placeholder: CircularProgressIndicator()));
    } else if (requestSucceeded) {
      return Expanded(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              addLocation();
            },
          ),
          body: Builder(
            builder: (BuildContext context) {
              if (locations.isEmpty) {
                return RequestPlaceholder(placeholder: Text('locations.no_locations'.tr()));
              } else {
                final Iterable<LocationTile> locationsTiles = locations.map((Location location) => LocationTile(
                      location: location,
                      onEdit: (Location location) {
                        editLocation(location);
                      },
                      onDelete: (Location location) {
                        showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) {
                          if (result ?? false) {
                            deleteLocation(location);
                          }
                        });
                      },
                    ));
                return ListView.separated(
                  padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64),
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
                            deleteLocation(location);
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
                            editLocation(location);
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
                );
              }
            },
          ),
        ),
      );
    } else {
      return Expanded(child: RequestPlaceholder(placeholder: Text('error.request_failed'.tr())));
    }
  }

  void editLocation(Location location) {
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

  void deleteLocation(Location location) {
    setState(() {
      locations.remove(location);
    });
  }

  Future<void> addLocation() async {
    final dynamic location = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const LocationDialog(edit: false);
        });
    if (location is Location) {
      final List<dynamic> result = await LocationService().addLocation(location);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(PopupSnackBar().getNewLocationSnackBar(context, result[0] as bool));
      }
      setState(() {
        getLocations();
      });
    }
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
