import 'package:cpm/common/routes/router_route.dart';
import 'package:cpm/utils/asset.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SideNavigation extends ConsumerStatefulWidget {
  const SideNavigation({super.key});

  @override
  ConsumerState<SideNavigation> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends ConsumerState<SideNavigation> {
  int _index = RouterRoute.currentDrawerIndex;

  void _navigate(int newIndex) {
    setState(() {
      _index = newIndex;
    });

    context.go(RouterRoute.getRouteFromIndex(_index).path);
  }

  void _back() {
    if (!context.canPop()) {
      return;
    }

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: IntrinsicHeight(
          child: NavigationRail(
            selectedIndex: _index,
            onDestinationSelected: _navigate,
            labelType: NavigationRailLabelType.all,
            leading: SvgPicture.asset(
              Asset.cpmSvg.path,
              width: Sizes.size64.size,
            ),
            destinations: [
              NavigationRailDestination(
                icon: const Icon(Icons.movie),
                label: Text(localizations.navigation_projects),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.people),
                label: Text(localizations.navigation_members),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.map),
                label: Text(localizations.navigation_locations),
              ),
              NavigationRailDestination(
                icon: const Icon(Icons.settings),
                label: Text(localizations.navigation_settings),
              ),
            ],
            trailing: Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BackButton(onPressed: _back),
                  Padding(padding: Paddings.padding8.bottom),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
