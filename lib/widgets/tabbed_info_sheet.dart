import 'package:flutter/material.dart';

import 'details_pane.dart';

class TabbedInfoSheet extends StatelessWidget {
  const TabbedInfoSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: const <Widget>[
            TabBar(tabs: <Tab>[
              Tab(
                text: 'Details',
              ),
              Tab(
                text: 'Members',
              ),
              Tab(
                text: 'Locations',
              ),
            ]),
            Expanded(
              child: TabBarView(children: <Widget>[
                DetailsPane(),
                Text('Members'),
                Text('Locations')
              ]),
            )
          ],
        ));
  }
}
