import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/episode.dart';
import '../details_panes/episode.dart';

class InfoSheetEpisode extends StatelessWidget {
  const InfoSheetEpisode({super.key, required this.episode});

  final Episode episode;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            TabBar(tabs: <Tab>[
              Tab(text: 'details.upper'.plural(2)),
              Tab(text: 'members.member.upper'.plural(2)),
              Tab(text: 'locations.location.upper'.plural(2))
            ]),
            Expanded(
                child: TabBarView(
              children: <Widget>[DetailsPaneEpisode(episode: episode), Text('Members'), Text('Locations')],
            ))
          ],
        ));
  }
}
