import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/common/sheets/episode/episode_details_tab.dart';
import 'package:cpm/common/sheets/project/link/project_links_tab.dart';
import 'package:cpm/common/sheets/project/project_details_tab.dart';
import 'package:cpm/common/sheets/sequence/sequence_details_tab.dart';
import 'package:cpm/common/sheets/sheet.dart';
import 'package:cpm/common/sheets/sheet_manager.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/project/link/link.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/radiuses.dart';
import 'package:cpm/utils/constants/sizes.dart';
import 'package:cpm/utils/extensions/string_validators.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectHeader extends StatelessWidget {
  const ProjectHeader.project({
    super.key,
    required this.delete,
    this.title,
    this.description,
    this.dateText,
    this.director,
    this.writer,
    this.links,
  })  : type = Project,
        location = null;

  const ProjectHeader.episode({
    super.key,
    required this.delete,
    this.title,
    this.description,
  })  : type = Episode,
        dateText = null,
        director = null,
        writer = null,
        links = null,
        location = null;

  const ProjectHeader.sequence({
    super.key,
    required this.delete,
    this.title,
    this.description,
    this.dateText,
    this.location,
  })  : type = Sequence,
        director = null,
        writer = null,
        links = null;

  final Function() delete;

  final Type type;
  final String? title;
  final String? description;
  final String? dateText;
  final String? director;
  final String? writer;
  final List<Link>? links;
  final Location? location;

  void _onMenuSelected(BuildContext context, MenuAction action) {
    switch (action) {
      case MenuAction.edit:
        _showSheet(context);
      case MenuAction.delete:
        delete();
      default:
    }
  }

  void _openLink(Link? link) {
    if (link == null) return;

    launchUrlString(link.getUrl, mode: LaunchMode.externalApplication);
  }

  void _showSheet(BuildContext context) {
    Widget sheet;

    switch (type) {
      case const (Project):
        sheet = Sheet(
          tabs: const [ProjectDetailsTab(), ProjectLinksTab()],
          icons: const [Icons.info, Icons.link],
        );
      case const (Episode):
        sheet = Sheet(
          tabs: const [EpisodeDetailsTab()],
          icons: const [Icons.info],
        );
      case const (Sequence):
        sheet = Sheet(
          tabs: const [SequenceDetailsTab()],
          icons: const [Icons.info],
        );
      default:
        throw Exception();
    }

    SheetManager().showSheet(context, sheet);
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    final noTitle = title == null || title!.isEmpty;
    final noDescription = description == null || description!.isEmpty;
    final noDates = dateText == null || dateText!.isEmpty;
    final noDirector = director == null || director!.isEmpty;
    final noWriter = writer == null || writer!.isEmpty;
    final noLinks = links == null || links!.isEmpty;
    final noLocation = location == null || location!.name == null;

    return Card(
      margin: Paddings.custom.zero,
      shape: RoundedRectangleBorder(borderRadius: Radiuses.radius0.circular),
      child: InkWell(
        onTap: () => _showSheet(context),
        child: Padding(
          padding: Paddings.padding8.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      noTitle ? localizations.projects_no_title : title!,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontStyle: noTitle ? FontStyle.italic : null,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton(
                    itemBuilder: (BuildContext context) {
                      return MenuAction.defaults.map((action) {
                        return PopupMenuItem(
                          value: action,
                          child: ListTile(
                            leading: Icon(action.icon),
                            title: Text(action.title),
                            contentPadding: Paddings.custom.zero,
                          ),
                        );
                      }).toList();
                    },
                    onSelected: (action) => _onMenuSelected(context, action),
                  ),
                ],
              ),
              Padding(padding: Paddings.padding4.vertical),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      noDescription ? localizations.projects_no_description : description!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontStyle: noDescription ? FontStyle.italic : null,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              if (type == Project || type == Sequence) ...[
                Padding(padding: Paddings.padding4.vertical),
                Row(
                  children: [
                    const Icon(Icons.calendar_month_outlined),
                    Padding(padding: Paddings.padding4.horizontal),
                    Expanded(
                      child: Text(
                        noDates ? localizations.projects_no_dates : dateText!,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontStyle: noDates ? FontStyle.italic : null,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
              if (type == Project) ...[
                Padding(padding: Paddings.padding4.vertical),
                Row(
                  children: [
                    const Icon(Icons.movie_outlined),
                    Padding(padding: Paddings.padding4.horizontal),
                    Expanded(
                      child: Text(
                        noDirector ? localizations.projects_no_director : director!,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontStyle: noDirector ? FontStyle.italic : null,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(padding: Paddings.padding4.vertical),
                Row(
                  children: [
                    const Icon(Icons.description_outlined),
                    Padding(padding: Paddings.padding4.horizontal),
                    Expanded(
                      child: Text(
                        noWriter ? localizations.projects_no_writer : writer!,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontStyle: noWriter ? FontStyle.italic : null,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(padding: Paddings.padding4.vertical),
                Row(
                  children: [
                    const Icon(Icons.link_outlined),
                    Padding(padding: Paddings.padding4.horizontal),
                    Expanded(
                      child: noLinks
                          ? Text(
                              localizations.projects_no_links,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : SizedBox(
                              height: Sizes.size32.size,
                              child: Scrollbar(
                                controller: scrollController,
                                thickness: !PlatformManager().isMobile ? 4 : 0,
                                child: ListView.builder(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: links?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final link = links![index];

                                    return TextButton(
                                      onPressed:
                                          link.url != null && link.url!.isOpenableUrl ? () => _openLink(link) : null,
                                      child: Text(link.getLabel),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ],
              if (type == Sequence) ...[
                Padding(padding: Paddings.padding4.vertical),
                Row(
                  children: [
                    const Icon(Icons.map),
                    Padding(padding: Paddings.padding4.horizontal),
                    Expanded(
                      child: Text(
                        noLocation ? localizations.projects_no_location : location!.getName,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontStyle: noLocation ? FontStyle.italic : null,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
