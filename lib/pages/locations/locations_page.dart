import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/model_tile.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/utils/constants/paddings.dart';
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
        onPressed: () => AddAction<Location>().add(context, ref),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(locationsProvider).when(
        data: (locations) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final location = locations[index];

              return ModelTile<Location>(
                delete: () => DeleteAction<Location>().delete(context, ref, id: location.id),
                model: location,
                leadingIcon: Icons.image,
                title: location.getName,
                subtitle: location.position,
                trailing: [
                  IconButton(
                    icon: Icon(MenuAction.map.icon),
                    onPressed: location.position != null && location.position!.isNotEmpty
                        ? () => MenuAction.map.function!(location.position!)
                        : null,
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(padding: Paddings.padding4.vertical);
            },
            itemCount: locations.length,
            padding: Paddings.withFab(Paddings.custom.page),
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
}
