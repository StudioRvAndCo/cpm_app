import 'package:cpm/utils/asset.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/sizes.dart';
import 'package:cpm/utils/routes/router_route.dart';
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
  int _selectedIndex = 0;

  void _onDestinationSelected(int? index) {
    if (index != null) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          context.goNamed(RouterRoute.projects.name);
        case 1:
          context.goNamed(RouterRoute.members.name);
        case 2:
          context.goNamed(RouterRoute.locations.name);
        case 3:
          context.goNamed(RouterRoute.settings.name);
      }
    }
  }

  void _back() {
    if (!context.canPop()) return;

    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: IntrinsicHeight(
          child: NavigationRail(
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
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
          ),
        ),
      ),
    );
  }
}
