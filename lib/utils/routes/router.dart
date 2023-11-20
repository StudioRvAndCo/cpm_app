import 'package:cpm/common/navigation/bottom_navigation.dart';
import 'package:cpm/common/navigation/side_navigation.dart';
import 'package:cpm/common/navigation/top_navigation.dart';
import 'package:cpm/pages/episodes/episodes_page.dart';
import 'package:cpm/pages/locations/locations_page.dart';
import 'package:cpm/pages/login/login_page.dart';
import 'package:cpm/pages/members/members_page.dart';
import 'package:cpm/pages/projects/projects_page.dart';
import 'package:cpm/pages/schedule/schedule_page.dart';
import 'package:cpm/pages/sequences/sequences_page.dart';
import 'package:cpm/pages/settings/settings_page.dart';
import 'package:cpm/pages/shots/shots_page.dart';
import 'package:cpm/services/authentication_service.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Page<dynamic> Function(BuildContext, GoRouterState) defaultPageBuilder<T>(Widget child) {
  return (BuildContext context, GoRouterState state) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  };
}

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RouterRoute.projects.path,
  redirect: (context, state) {
    if (!AuthenticationService().isAuthenticated) {
      return RouterRoute.login.path;
    }

    return null;
  },
  routes: [
    GoRoute(
      name: RouterRoute.login.name,
      path: RouterRoute.login.path,
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          appBar: PlatformManager().isMobile ? const TopNavigation() : null,
          body: Row(
            children: [
              if (!PlatformManager().isMobile) const SideNavigation(),
              Expanded(
                child: child,
              ),
            ],
          ),
          bottomNavigationBar: PlatformManager().isMobile ? const BottomNavigation() : null,
        );
      },
      routes: [
        GoRoute(
          name: RouterRoute.projects.name,
          path: RouterRoute.projects.path,
          pageBuilder: defaultPageBuilder(const ProjectsPage()),
          routes: [
            GoRoute(
              name: RouterRoute.episodes.name,
              path: RouterRoute.episodes.path,
              pageBuilder: defaultPageBuilder(const EpisodesPage()),
            ),
            GoRoute(
              name: RouterRoute.sequences.name,
              path: RouterRoute.sequences.path,
              pageBuilder: defaultPageBuilder(const SequencesPage()),
            ),
            GoRoute(
              name: RouterRoute.shots.name,
              path: RouterRoute.shots.path,
              pageBuilder: defaultPageBuilder(const ShotsPage()),
            ),
            GoRoute(
              name: RouterRoute.schedule.name,
              path: RouterRoute.schedule.path,
              pageBuilder: defaultPageBuilder(const SchedulePage()),
            ),
          ],
        ),
        GoRoute(
          name: RouterRoute.members.name,
          path: RouterRoute.members.path,
          pageBuilder: defaultPageBuilder(const MembersPage()),
        ),
        GoRoute(
          name: RouterRoute.locations.name,
          path: RouterRoute.locations.path,
          pageBuilder: defaultPageBuilder(const LocationsPage()),
        ),
        GoRoute(
          name: RouterRoute.settings.name,
          path: RouterRoute.settings.path,
          pageBuilder: defaultPageBuilder(const SettingsPage()),
        ),
      ],
    ),
  ],
);
