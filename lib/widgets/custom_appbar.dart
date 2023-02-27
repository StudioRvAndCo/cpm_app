import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../pages/login.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

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
        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.push(
                  context, PageTransition<Login>(type: PageTransitionType.topToBottom, child: const Login()));
            }),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
