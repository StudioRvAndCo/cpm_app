import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../pages/about.dart';
import '../pages/home.dart';
import '../pages/login.dart';
import '../pages/members.dart';
import '../pages/planning.dart';
import '../pages/test.dart';

// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: Login, name: 'LoginRoute', path: '/login', initial: true),
    AutoRoute(page: Home, name: 'HomeRoute', path: '/home'),
    AutoRoute(page: Members, name: 'MembersRoute'),
    AutoRoute(page: About, name: 'AboutRoute'),
    AutoRoute(page: Planning, name: 'PlanningRoute'),
    AutoRoute(page: Test, name: 'TestRoute'),
  ],
)
class $AppRouter {}
