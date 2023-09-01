import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/authentication/authentication.dart';
import 'logout.dart';

class CustomAppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  ConsumerState<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends ConsumerState<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () {
          Scaffold.of(context).openDrawer();
        },
      ),
      title: const Center(child: Text('CPM')),
      actions: <IconButton>[
        IconButton(icon: const Icon(Icons.logout), onPressed: () => logout()),
      ],
    );
  }

  Future<void> logout() async {
    if (await Logout().confirm(context)) {
      ref.read(authenticationProvider.notifier).logout();
    }
  }
}
