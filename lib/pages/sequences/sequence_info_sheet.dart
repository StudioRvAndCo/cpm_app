import 'package:cpm/pages/sequences/sequence_details_pane.dart';
import 'package:cpm/utils/constants/constants.dart';
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
              Tab(text: localizations.projects_details),
              Tab(text: localizations.members_members(2)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                const SequenceDetailsPane(),
                Center(child: Text(localizations.coming_soon)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
