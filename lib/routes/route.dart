// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/annotations.dart';

import '../pages/home.dart';
import '../pages/information.dart';
import '../pages/login.dart';
import '../pages/members.dart';
import '../pages/test.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: Login, initial: true),
    AutoRoute(page: Home),
    AutoRoute(page: Members),
    AutoRoute(page: Information),
    AutoRoute(page: Test),
  ],
)
class $AppRouter {}
