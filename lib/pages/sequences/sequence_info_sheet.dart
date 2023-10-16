import 'package:cpm/pages/sequences/sequence_details_pane.dart';
import 'package:flutter/material.dart';

class SequenceInfoSheet extends StatelessWidget {
  const SequenceInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: <Tab>[
              Tab(text: 'details.upper'),
              Tab(text: 'members.member.upper'),
            ],
          ),
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
