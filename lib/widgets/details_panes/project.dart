import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../../services/project.dart';
import '../icon_label.dart';
import '../request_placeholder.dart';
import '../snack_bars.dart';

class DetailsPaneProject extends StatefulWidget {
  const DetailsPaneProject({super.key, required this.project});

  final Project project;

  @override
  State<DetailsPaneProject> createState() => _DetailsPaneProjectState();
}

class _DetailsPaneProjectState extends State<DetailsPaneProject>
    with AutomaticKeepAliveClientMixin<DetailsPaneProject> {
  bool requestCompleted = false;
  late bool requestSucceeded;
  late Project editedProject;

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCompleteProject();
    titleController.text = widget.project.title;
    descriptionController.text = widget.project.description;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    if (!requestCompleted) {
      return const RequestPlaceholder(placeholder: CircularProgressIndicator());
    } else if (requestSucceeded) {
      return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: <Widget>[
              Focus(
                onFocusChange: (bool focus) {
                  if (!focus) {
                    editTitle();
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
              Expanded(
                child: Focus(
                  onFocusChange: (bool focus) {
                    if (!focus) {
                      editDescription();
                    }
                  },
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    expands: true,
                    maxLength: 280,
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 16)),
              GestureDetector(
                onTap: () async {
                  final DateTimeRange? pickedRange = await showDateRangePicker(
                      context: context,
                      initialDateRange: DateTimeRange(start: editedProject.startDate, end: editedProject.endDate),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101));
                  if (pickedRange != null) {
                    editDate(pickedRange.start, pickedRange.end);
                  }
                },
                behavior: HitTestBehavior.translucent,
                child: IconLabel(
                  text: getDateText(),
                  icon: Icons.event_outlined,
                  textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            ],
          ));
    } else {
      return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
    }
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> getCompleteProject() async {
    final List<dynamic> result = await ProjectService().getCompleteProject(widget.project.id);
    setState(() {
      requestCompleted = true;
      requestSucceeded = result[0] as bool;
      editedProject = result[1] as Project;
    });
  }

  String getDateText() {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(editedProject.startDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(editedProject.endDate);
    return '$firstText - $lastText';
  }

  void editTitle() {
    editedProject.title = titleController.text;
    editProject();
  }

  void editDescription() {
    editedProject.description = descriptionController.text;
    editProject();
  }

  void editDate(DateTime startDate, DateTime endDate) {
    setState(() {
      editedProject.startDate = startDate;
      editedProject.endDate = endDate;
    });
    editProject();
  }

  Future<void> editProject() async {
    final List<dynamic> result = await ProjectService().editProject(editedProject);
    if (context.mounted) {
      final bool succeeded = result[0] as bool;
      ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, result[1] as int,
          message: succeeded ? 'snack_bars.project.edited'.tr() : 'snack_bars.project.not_edited'.tr()));
    }
  }
}
