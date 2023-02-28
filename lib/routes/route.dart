import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';

import '../pages/home.dart';
import '../pages/information.dart';
import '../pages/login.dart';
import '../pages/members.dart';
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
    AutoRoute(page: Information, name: 'InformationRoute'),
    AutoRoute(page: Test, name: 'TestRoute'),
  ],
)
class $AppRouter {}
