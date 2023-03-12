import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../details_panes/project.dart';

class InfoSheetProject extends StatelessWidget {
  const InfoSheetProject({super.key, required this.project});

  final Project project;

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
                children: <Widget>[DetailsPaneProject(project: project), Text('Members'), Text('Locations')],
              ),
            )
          ],
        ));
  }
}
