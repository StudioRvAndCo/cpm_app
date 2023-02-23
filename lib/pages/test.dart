import 'package:flutter/material.dart';

import '../widgets/tabbed_info_sheet.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const TabbedInfoSheet();
                });
          },
          child: const Text('Bottom sheet')),
    );
  }
}
