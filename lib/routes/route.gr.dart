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
    Login.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.Login(),
      );
    },
    Home.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.Home(),
      );
    },
    Members.name: (routeData) {
      final args = routeData.argsAs<MembersArgs>();
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i3.Members(
          key: args.key,
          members: args.members,
        ),
      );
    },
    Information.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.Information(),
      );
    },
    Test.name: (routeData) {
      return _i6.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.Test(),
      );
    },
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(
          Login.name,
          path: '/',
        ),
        _i6.RouteConfig(
          Home.name,
          path: '/Home',
        ),
        _i6.RouteConfig(
          Members.name,
          path: '/Members',
        ),
        _i6.RouteConfig(
          Information.name,
          path: '/Information',
        ),
        _i6.RouteConfig(
          Test.name,
          path: '/Test',
        ),
      ];
}

/// generated route for
/// [_i1.Login]
class Login extends _i6.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i2.Home]
class Home extends _i6.PageRouteInfo<void> {
  const Home()
      : super(
          Home.name,
          path: '/Home',
        );

  static const String name = 'Home';
}

/// generated route for
/// [_i3.Members]
class Members extends _i6.PageRouteInfo<MembersArgs> {
  Members({
    _i8.Key? key,
    required List<_i9.Member> members,
  }) : super(
          Members.name,
          path: '/Members',
          args: MembersArgs(
            key: key,
            members: members,
          ),
        );

  static const String name = 'Members';
}

class MembersArgs {
  const MembersArgs({
    this.key,
    required this.members,
  });

  final _i8.Key? key;

  final List<_i9.Member> members;

  @override
  String toString() {
    return 'MembersArgs{key: $key, members: $members}';
  }
}

/// generated route for
/// [_i4.Information]
class Information extends _i6.PageRouteInfo<void> {
  const Information()
      : super(
          Information.name,
          path: '/Information',
        );

  static const String name = 'Information';
}

/// generated route for
/// [_i5.Test]
class Test extends _i6.PageRouteInfo<void> {
  const Test()
      : super(
          Test.name,
          path: '/Test',
        );

  static const String name = 'Test';
}
