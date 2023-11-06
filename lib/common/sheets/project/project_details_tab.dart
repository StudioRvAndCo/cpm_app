import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProjectDetailsTab extends ConsumerStatefulWidget {
  const ProjectDetailsTab({super.key});

  @override
  ConsumerState<ProjectDetailsTab> createState() => _ProjectDetailsTabState();
}

class _ProjectDetailsTabState extends ConsumerState<ProjectDetailsTab> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  DateTimeRange dateRange = DateTimeRange(
    start: DateTime.now(),
    end: DateTime.now().weekLater,
  );

  @override
  void initState() {
    super.initState();

    final project = ref.read(currentProjectProvider).value;
    title.text = project?.title ?? '';
    description.text = project?.description ?? '';
    dateRange = DateTimeRange(
      start: project?.startDate ?? DateTime.now(),
      end: project?.endDate ?? DateTime.now().weekLater,
    );
  }

  Future<void> _pickDateRange(Project project) async {
    await showDateRangePicker(
      context: context,
      initialDateRange: dateRange,
      firstDate: DateTime.now().hundredYearsBefore,
      lastDate: DateTime.now().hundredYearsLater,
    ).then((pickedDateRange) {
      if (pickedDateRange == null) return;

      dateRange = pickedDateRange;
      _edit(project);
    });
  }

  void _onSubmitted(Project project) {
    if (title.text == project.title && description.text == project.description) return;

    _edit(project);
  }

  void _edit(Project project) {
    project.title = title.text;
    project.description = description.text;
    project.startDate = dateRange.start;
    project.endDate = dateRange.end;

    ref.read(projectsProvider.notifier).edit(project);
    ref.read(currentProjectProvider.notifier).set(project);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentProjectProvider).when(
      data: (project) {
        return Column(
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.calendar_month),
              label: Text('${dateRange.start.yMd} - ${dateRange.end.yMd}'),
              onPressed: () => _pickDateRange(project),
            ),
            Padding(padding: Paddings.padding8.vertical),
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(project) : null,
              child: TextField(
                controller: title,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_title,
                ),
                onSubmitted: (_) => _onSubmitted(project),
              ),
            ),
            Padding(padding: Paddings.padding8.vertical),
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(project) : null,
              child: TextField(
                controller: description,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_description,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                onSubmitted: (_) => _onSubmitted(project),
              ),
            ),
          ],
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
}
