import 'package:cpm/utils/asset.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/package_info_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TopNavigation extends StatelessWidget implements PreferredSizeWidget {
  const TopNavigation();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: Paddings.padding8.all,
        child: Image.asset(
          Asset.cpm.path,
          filterQuality: FilterQuality.medium,
        ),
      ),
      title: Text(PackageInfoManager().name),
      systemOverlayStyle: SystemUiOverlayStyle(
        systemNavigationBarColor: ElevationOverlay.applySurfaceTint(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.primary,
          3,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
