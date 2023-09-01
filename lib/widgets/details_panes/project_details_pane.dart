import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project/project.dart';
import '../../providers/projects/projects.dart';
import '../../utils/constants_globals.dart';
import '../icon_label.dart';

class ProjectDetailsPane extends ConsumerStatefulWidget {
  const ProjectDetailsPane({super.key});

  @override
  ConsumerState<ProjectDetailsPane> createState() => _DetailsPaneProjectState();
}

class _DetailsPaneProjectState extends ConsumerState<ProjectDetailsPane> {
  late DateTime start;
  late DateTime end;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) {
        start = project.getStartDate;
        end = project.getEndDate;
        titleController.text = project.getTitle;
        descriptionController.text = project.getDescription;
        titleController.selection = TextSelection.collapsed(offset: titleController.text.length);
        descriptionController.selection = TextSelection.collapsed(offset: descriptionController.text.length);

        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Focus(
                onFocusChange: (bool hasFocus) {
                  if (!hasFocus && titleController.text != project.title) {
                    edit(project);
                  }
                },
                child: TextField(
                  style: Theme.of(context).textTheme.titleMedium,
                  decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
                  controller: titleController,
                  maxLength: 64,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              Focus(
                onFocusChange: (bool hasFocus) {
                  if (!hasFocus && descriptionController.text != project.description) {
                    edit(project);
                  }
                },
                child: TextField(
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: null,
                  maxLength: 280,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              GestureDetector(
                onTap: () => editDate(project),
                behavior: HitTestBehavior.translucent,
                child: IconLabel(
                  text: getDateText(),
                  icon: Icons.event,
                  textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return requestPlaceholderError;
      },
      loading: () {
        return requestPlaceholderLoading;
      },
    );
  }

  String getDateText() {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(start);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(end);

    return '$firstText - $lastText';
  }

  Future<void> editDate(Project project) async {
    final DateTimeRange? newDates = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: start, end: end),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (newDates != null) {
      setState(() {
        start = newDates.start;
        end = newDates.end;
      });
    }
    edit(project);
  }

  void edit(Project project) {
    project.title = titleController.text;
    project.description = descriptionController.text;
    project.startDate = start;
    project.endDate = end;

    ref.read(projectsProvider.notifier).edit(project);
    ref.read(currentProjectProvider.notifier).set(project);
  }
}
