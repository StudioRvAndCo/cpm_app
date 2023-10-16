import 'package:cpm/pages/episodes/episode_details_pane.dart';
import 'package:cpm/utils/constants/constants.dart';
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
              Tab(text: localizations.projects_details),
              Tab(text: localizations.members_members(2)),
              Tab(text: localizations.locations_location(2)),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: <Widget>[
                const EpisodeDetailsPane(),
                Center(child: Text(localizations.coming_soon)),
                Center(child: Text(localizations.coming_soon)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
