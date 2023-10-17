import 'package:cpm/common/dialogs/confirm_dialog.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/pages/locations/location_dialog.dart';
import 'package:cpm/pages/locations/location_tile.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/separators.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LocationsPage extends ConsumerStatefulWidget {
  const LocationsPage({super.key});

  @override
  ConsumerState<LocationsPage> createState() => _LocationsState();
}

class _LocationsState extends ConsumerState<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => add(),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(locationsProvider).when(
        data: (List<Location> locations) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ClipRRect(
                clipBehavior: Clip.hardEdge,
                child: Dismissible(
                  key: UniqueKey(),
                  background: deleteBackground(),
                  secondaryBackground: editBackground(),
                  confirmDismiss: (DismissDirection dismissDirection) async {
                    switch (dismissDirection) {
                      case DismissDirection.endToStart:
                        edit(locations[index]);
                        return false;
                      case DismissDirection.startToEnd:
                        return await showConfirmationDialog(
                              context,
                              localizations.dialog_delete_name_confirmation(locations[index].getName),
                            ) ??
                            false;
                      case DismissDirection.horizontal:
                      case DismissDirection.vertical:
                      case DismissDirection.up:
                      case DismissDirection.down:
                      case DismissDirection.none:
                        assert(false);
                    }

                    return false;
                  },
                  onDismissed: (DismissDirection direction) {
                    switch (direction) {
                      case DismissDirection.startToEnd:
                        delete(locations[index]);
                      default:
                        throw Exception();
                    }
                  },
                  child: LocationTile(
                    location: locations[index],
                    onEdit: (Location location) {
                      edit(location);
                    },
                    onDelete: (Location location) {
                      showConfirmationDialog(
                        context,
                        localizations.dialog_delete_name_confirmation(location.getName),
                      ).then((bool? result) {
                        if (result ?? false) {
                          delete(location);
                        }
                      });
                    },
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Separator.divider1.divider;
            },
            itemCount: locations.length,
          );
        },
        error: (Object error, StackTrace stackTrace) {
          return requestPlaceholderError;
        },
        loading: () {
          return requestPlaceholderLoading;
        },
      ),
    );
  }

  Future<void> add() async {
    final location = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LocationDialog();
      },
    );
    if (location is Location) {
      final added = await ref.read(locationsProvider.notifier).add(location);
      SnackBarManager().show(
        added
            ? getInfoSnackBar(
                localizations.snack_bar_add_success_item(localizations.item_location, Gender.male.name),
              )
            : getErrorSnackBar(
                localizations.snack_bar_add_fail_item(localizations.item_location, Gender.male.name),
              ),
      );
    }
  }

  Future<void> edit(Location location) async {
    final editedLocation = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LocationDialog(location: location);
      },
    );
    if (editedLocation is Location) {
      final edited = await ref.read(locationsProvider.notifier).edit(editedLocation);
      SnackBarManager().show(
        edited
            ? getInfoSnackBar(
                localizations.snack_bar_edit_success_item(localizations.item_location, Gender.male.name),
              )
            : getErrorSnackBar(
                localizations.snack_bar_edit_fail_item(localizations.item_location, Gender.male.name),
              ),
      );
    }
  }

  Future<void> delete(Location location) async {
    final deleted = await ref.read(locationsProvider.notifier).delete(location.id);
    SnackBarManager().show(
      deleted
          ? getInfoSnackBar(
              localizations.snack_bar_delete_success_item(localizations.item_location, Gender.male.name),
            )
          : getErrorSnackBar(
              localizations.snack_bar_delete_fail_item(localizations.item_location, Gender.male.name),
            ),
    );
  }
}
