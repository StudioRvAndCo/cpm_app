import 'package:cpm/pages/projects/links/links_tab.dart';
import 'package:cpm/pages/projects/project_details_pane.dart';
import 'package:flutter/material.dart';

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
              Tab(text: 'details.upper'),
              Tab(text: 'links.upper'),
              Tab(text: 'members.member.upper'),
              Tab(text: 'locations.location.upper'),
            ],
          ),
          Builder(
            builder: (BuildContext builder) {
              if (_selectedTab == 0) {
                return const ProjectDetailsPane();
              } else if (_selectedTab == 1) {
                return const LinksTab();
              } else if (_selectedTab == 2) {
                return const Center(child: Text('Coming soon!'));
              } else if (_selectedTab == 3) {
                return const Center(child: Text('Coming soon!'));
              } else {
                throw Exception();
              }
            },
          ),
        ],
      ),
    );
  }
}
