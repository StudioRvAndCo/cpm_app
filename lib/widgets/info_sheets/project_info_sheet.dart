import 'package:cpm/widgets/details_panes/links/links_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../exceptions/invalid_tab_index.dart';
import '../details_panes/project_details_pane.dart';

class ProjectInfoSheet extends StatefulWidget {
  const ProjectInfoSheet({super.key});

  @override
  State<ProjectInfoSheet> createState() => _ProjectInfoSheetState();
}

class _ProjectInfoSheetState extends State<ProjectInfoSheet> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
            controller: _tabController,
            onTap: (int index) {
              setState(() {
                _selectedTab = index;
              });
            },
            tabs: [
              Tab(text: 'details.upper'.plural(2)),
              Tab(text: 'links.upper'.plural(2)),
              Tab(text: 'members.member.upper'.plural(2)),
              Tab(text: 'locations.location.upper'.plural(2)),
            ],
          ),
          Builder(builder: (BuildContext builder) {
            if (_selectedTab == 0) {
              return const ProjectDetailsPane();
            } else if (_selectedTab == 1) {
              return const LinksTab();
            } else if (_selectedTab == 2) {
              return const Center(child: Text('Coming soon!'));
            } else if (_selectedTab == 3) {
              return const Center(child: Text('Coming soon!'));
            } else {
              throw InvalidTabIndex('Invalid tab index: $_selectedTab');
            }
          }),
        ],
      ),
    );
  }
}
