import 'package:flutter/material.dart';

import '../widgets/new_project_dialog.dart';
import '../widgets/tabbed_info_sheet.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const TabbedInfoSheet();
                });
          },
          child: const Text('Bottom sheet')),
      TextButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const NewProjectDialog();
                });
          },
          child: const Text('New Project'))
    ]);
  }
}
