import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/project.dart';
import '../icon_label.dart';

class DetailsPaneProject extends StatefulWidget {
  const DetailsPaneProject({super.key, required this.project});

  final Project project;

  @override
  State<DetailsPaneProject> createState() => _DetailsPaneProjectState();
}

class _DetailsPaneProjectState extends State<DetailsPaneProject>
    with AutomaticKeepAliveClientMixin<DetailsPaneProject> {
  late String title;
  late String description;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();

    title = widget.project.title;
    description = widget.project.description;
    startDate = widget.project.beginDate;
    endDate = widget.project.endDate;

    titleController.text = title;
    descriptionController.text = description;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: <Widget>[
            TextField(
              style: Theme.of(context).textTheme.titleMedium,
              decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
              controller: titleController,
              onChanged: setTitle,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
              controller: descriptionController,
              onChanged: setDescription,
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
                    initialDateRange: DateTimeRange(start: startDate, end: endDate), //get today's date
                    firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));
                if (pickedRange != null) {
                  startDate = pickedRange.start;
                  endDate = pickedRange.end;
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
  }

  @override
  bool get wantKeepAlive => true;

  void setTitle(String value) {
    setState(() {
      title = value;
    });
  }

  void setDescription(String value) {
    setState(() {
      description = value;
    });
  }

  String getDateText() {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(startDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(endDate);
    return '$firstText - $lastText';
  }
}
