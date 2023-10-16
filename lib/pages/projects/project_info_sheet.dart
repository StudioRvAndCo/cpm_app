import 'package:cpm/pages/projects/links/links_tab.dart';
import 'package:cpm/pages/projects/project_details_pane.dart';
import 'package:cpm/utils/constants/constants.dart';
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
              Tab(text: localizations.projects_details),
              Tab(text: localizations.projects_links),
              Tab(text: localizations.members_members(2)),
              Tab(text: localizations.locations_location(2)),
            ],
          ),
          Builder(
            builder: (BuildContext builder) {
              if (_selectedTab == 0) {
                return const ProjectDetailsPane();
              } else if (_selectedTab == 1) {
                return const LinksTab();
              } else if (_selectedTab == 2) {
                return Center(child: Text(localizations.coming_soon));
              } else if (_selectedTab == 3) {
                return Center(child: Text(localizations.coming_soon));
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
