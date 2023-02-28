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
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/foundation.dart' as _i8;
import 'package:flutter/material.dart' as _i7;

import '../models/member.dart' as _i9;
import '../pages/home.dart' as _i2;
import '../pages/information.dart' as _i4;
import '../pages/login.dart' as _i1;
import '../pages/members.dart' as _i3;
import '../pages/test.dart' as _i5;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i1.Login(
          key: args.key,
          onLogin: args.onLogin,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.Home(),
      );
    },
    MembersRoute.name: (routeData) {
      final args = routeData.argsAs<MembersRouteArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.Members(
          key: args.key,
          members: args.members,
        ),
      );
    },
    InformationRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.Information(),
      );
    },
    TestRoute.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.Test(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          '/#redirect',
          path: '/',
          redirectTo: '/login',
          fullMatch: true,
        ),
        _i6.RouteConfig(
          LoginRoute.name,
          path: '/login',
        ),
        _i6.RouteConfig(
          HomeRoute.name,
          path: '/home',
        ),
        _i6.RouteConfig(
          MembersRoute.name,
          path: '/Members',
        ),
        _i6.RouteConfig(
          InformationRoute.name,
          path: '/Information',
        ),
        _i6.RouteConfig(
          TestRoute.name,
          path: '/Test',
        ),
      ];
}

/// generated route for
/// [_i1.Login]
class LoginRoute extends _i6.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i8.Key? key,
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

  final _i8.Key? key;

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
class HomeRoute extends _i6.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i3.Members]
class MembersRoute extends _i6.PageRouteInfo<MembersRouteArgs> {
  MembersRoute({
    _i8.Key? key,
    required List<_i9.Member> members,
  }) : super(
          MembersRoute.name,
          path: '/Members',
          args: MembersRouteArgs(
            key: key,
            members: members,
          ),
        );

  static const String name = 'MembersRoute';
}

class MembersRouteArgs {
  const MembersRouteArgs({
    this.key,
    required this.members,
  });

  final _i8.Key? key;

  final List<_i9.Member> members;

  @override
  String toString() {
    return 'MembersRouteArgs{key: $key, members: $members}';
  }
}

/// generated route for
/// [_i4.Information]
class InformationRoute extends _i6.PageRouteInfo<void> {
  const InformationRoute()
      : super(
          InformationRoute.name,
          path: '/Information',
        );

  static const String name = 'InformationRoute';
}

/// generated route for
/// [_i5.Test]
class TestRoute extends _i6.PageRouteInfo<void> {
  const TestRoute()
      : super(
          TestRoute.name,
          path: '/Test',
        );

  static const String name = 'TestRoute';
}
