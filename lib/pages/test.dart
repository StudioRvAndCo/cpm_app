import 'package:flutter/material.dart';

import '../dialogs/new_project.dart';
import '../dialogs/new_sequence.dart';
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
                  return const NewSequenceDialog(locations: [
                    'Maison de Bastien1',
                    'Maison de Bastien2',
                    'Maison de Bastien3',
                    'Maison de Bastien4',
                    'Maison de Bastien5',
                    'Maison de Bastien6',
                  ]);
                });
          },
          child: const Text('New Sequence')),
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
