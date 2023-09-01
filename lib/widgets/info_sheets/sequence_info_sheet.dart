import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../details_panes/sequence_details_pane.dart';

class SequenceInfoSheet extends StatelessWidget {
  const SequenceInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(tabs: <Tab>[
            Tab(text: 'details.upper'.plural(2)),
            Tab(text: 'members.member.upper'.plural(2)),
          ]),
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                SequenceDetailsPane(),
                Center(child: Text('Coming soon!')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
