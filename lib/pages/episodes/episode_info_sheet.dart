import 'package:cpm/pages/episodes/episode_details_pane.dart';
import 'package:flutter/material.dart';

class EpisodeInfoSheet extends StatelessWidget {
  const EpisodeInfoSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: <Widget>[
          TabBar(
            tabs: <Tab>[
              Tab(text: 'details.upper'),
              Tab(text: 'members.member.upper'),
              Tab(text: 'locations.location.upper'),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: <Widget>[
                EpisodeDetailsPane(),
                Center(child: Text('Coming soon!')),
                Center(child: Text('Coming soon!')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
