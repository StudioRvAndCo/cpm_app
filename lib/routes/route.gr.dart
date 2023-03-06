// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/foundation.dart' as _i9;
import 'package:flutter/material.dart' as _i8;

import '../models/project.dart' as _i10;
import '../pages/home.dart' as _i2;
import '../pages/information.dart' as _i4;
import '../pages/login.dart' as _i1;
import '../pages/members.dart' as _i3;
import '../pages/planning.dart' as _i5;
import '../pages/test.dart' as _i6;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.Login(
          key: args.key,
          onLogin: args.onLogin,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.Home(),
      );
    },
    MembersRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.Members(),
      );
    },
    InformationRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.Information(),
      );
    },
    PlanningRoute.name: (routeData) {
      final args = routeData.argsAs<PlanningRouteArgs>();
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i5.Planning(
          key: args.key,
          project: args.project,
        ),
      );
    },
    TestRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.Test(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        _i7.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i7.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i7.RouteConfig(
          MembersRoute.name,
          path: '/Members',
        ),
        _i7.RouteConfig(
          InformationRoute.name,
          path: '/Information',
        ),
        _i7.RouteConfig(
          PlanningRoute.name,
          path: '/Planning',
        ),
        _i7.RouteConfig(
          TestRoute.name,
          path: '/Test',
        ),
      ];
}

/// generated route for
/// [_i1.Login]
class LoginRoute extends _i7.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i9.Key? key,
    required void Function(
      String,
      String,
    )
        onLogin,
  }) : super(
          LoginRoute.name,
          path: '/login',
          args: LoginRouteArgs(
            key: key,
            onLogin: onLogin,
          ),
        );

  static const String name = 'LoginRoute';
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onLogin,
  });

  final _i9.Key? key;

  final void Function(
    String,
    String,
  ) onLogin;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onLogin: $onLogin}';
  }
}

/// generated route for
/// [_i2.Home]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.Members]
class MembersRoute extends _i7.PageRouteInfo<void> {
  const MembersRoute()
      : super(
          MembersRoute.name,
          path: '/Members',
        );

  static const String name = 'MembersRoute';
}

/// generated route for
/// [_i4.Information]
class InformationRoute extends _i7.PageRouteInfo<void> {
  const InformationRoute()
      : super(
          InformationRoute.name,
          path: '/Information',
        );

  static const String name = 'InformationRoute';
}

/// generated route for
/// [_i5.Planning]
class PlanningRoute extends _i7.PageRouteInfo<PlanningRouteArgs> {
  PlanningRoute({
    _i9.Key? key,
    required _i10.Project project,
  }) : super(
          PlanningRoute.name,
          path: '/Planning',
          args: PlanningRouteArgs(
            key: key,
            project: project,
          ),
        );

  static const String name = 'PlanningRoute';
}

class PlanningRouteArgs {
  const PlanningRouteArgs({
    this.key,
    required this.project,
  });

  final _i9.Key? key;

  final _i10.Project project;

  @override
  String toString() {
    return 'PlanningRouteArgs{key: $key, project: $project}';
  }
}

/// generated route for
/// [_i6.Test]
class TestRoute extends _i7.PageRouteInfo<void> {
  const TestRoute()
      : super(
          TestRoute.name,
          path: '/Test',
        );

  static const String name = 'TestRoute';
}
