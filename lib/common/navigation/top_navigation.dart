import 'package:cpm/utils/asset.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';

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
      title: Text(localizations.app_name),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
