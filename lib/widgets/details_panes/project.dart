import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../../services/project.dart';
import '../icon_label.dart';
import '../request_placeholder.dart';

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
              TextField(
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
                controller: titleController,
                onChanged: editTitle,
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
                controller: descriptionController,
                onChanged: editDescription,
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              const SizedBox(
                height: 20,
              ),
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
              )
            ],
          ));
    } else {
      return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
    }
  }

  @override
  bool get wantKeepAlive => true;

  Future<void> getCompleteProject() async {
    final List<dynamic> result = await ProjectService().getProject(widget.project.id);
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

  void editTitle(String value) {
    editedProject.title = value;
    updateProject();
  }

  void editDescription(String value) {
    editedProject.description = value;
    updateProject();
  }

  void editDate(DateTime startDate, DateTime endDate) {
    editedProject.startDate = startDate;
    editedProject.endDate = endDate;
    updateProject();
  }

  void updateProject() {
    setState(() {
      ProjectService().editProject(editedProject);
      print('updated');
    });
  }
}
