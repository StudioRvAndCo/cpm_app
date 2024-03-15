import 'package:cpm/common/navigation/bottom_navigation.dart';
import 'package:cpm/common/navigation/side_navigation.dart';
import 'package:cpm/common/navigation/top_navigation.dart';
import 'package:cpm/common/routes/router_route.dart';
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
import 'package:cpm/utils/platform.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
      path: RouterRoute.login.path,
      builder: (context, state) => const LoginPage(),
    ),
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          appBar: kIsMobile ? const TopNavigation() : null,
          body: Row(
            children: [
              if (!kIsMobile) const SideNavigation(),
              Expanded(
                child: child,
              ),
            ],
          ),
          bottomNavigationBar: kIsMobile ? const BottomNavigation() : null,
        );
      },
      routes: [
        GoRoute(
          path: RouterRoute.projects.path,
          builder: (context, state) => const ProjectsPage(),
          routes: [
            GoRoute(
              path: RouterRoute.episodes.path,
              builder: (context, state) => const EpisodesPage(),
            ),
            GoRoute(
              path: RouterRoute.sequences.path,
              builder: (context, state) => const SequencesPage(),
            ),
            GoRoute(
              path: RouterRoute.shots.path,
              builder: (context, state) => const ShotsPage(),
            ),
            GoRoute(
              path: RouterRoute.schedule.path,
              builder: (context, state) => const SchedulePage(),
            ),
          ],
        ),
        GoRoute(
          path: RouterRoute.members.path,
          builder: (context, state) => const MembersPage(),
        ),
        GoRoute(
          path: RouterRoute.locations.path,
          builder: (context, state) => const LocationsPage(),
        ),
        GoRoute(
          path: RouterRoute.settings.path,
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
