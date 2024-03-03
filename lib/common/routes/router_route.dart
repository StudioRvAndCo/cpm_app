import 'package:collection/collection.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/go_router_extension.dart';
import 'package:go_router/go_router.dart';

enum RouterRoute {
  // Top routes
  projects('/projects', drawerIndex: 0),
  members('/members', drawerIndex: 1),
  locations('/locations', drawerIndex: 2),
  settings('/settings', drawerIndex: 3),
  login('/login'),

  // Sub routes
  episodes('episodes', fullPath: '/projects/episodes'),
  sequences('sequences', fullPath: '/projects/sequences'),
  shots('shots', fullPath: '/projects/shots'),
  schedule('schedule', fullPath: '/projects/schedule'),
  ;

  final String path;
  final String? fullPath;
  final int? drawerIndex;

  const RouterRoute(this.path, {this.fullPath, this.drawerIndex});

  String get title {
    switch (this) {
      case projects:
        return localizations.navigation_projects;
      case members:
        return localizations.navigation_members;
      case locations:
        return localizations.navigation_locations;
      case settings:
        return localizations.navigation_settings;
      default:
        throw Exception('Unexpected route: $this');
    }
  }

  static int get currentDrawerIndex {
    final drawerIndex = currentRoute.drawerIndex;

    if (drawerIndex == null) throw Exception('No current drawer index');

    return drawerIndex;
  }

  static RouterRoute getRouteFromIndex(int index) {
    final route = values.firstWhereOrNull((route) => route.drawerIndex == index);

    if (route == null) throw Exception('No route for index: $index');

    return route;
  }

  static RouterRoute get currentRoute {
    final location = GoRouter.of(navigatorKey.currentContext!).location();

    if (location == projects.path) {
      return projects;
    } else if (location == members.path) {
      return members;
    } else if (location == locations.path) {
      return locations;
    } else if (location == settings.path) {
      return settings;
    } else if (location == login.path) {
      return login;
    } else if (location.contains(episodes.path)) {
      return episodes;
    } else if (location.contains(sequences.path)) {
      return sequences;
    } else if (location.contains(shots.path)) {
      return shots;
    } else {
      throw Exception('Unknown route location: $location');
    }
  }
}
