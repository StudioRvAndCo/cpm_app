import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/sequence.dart';
import '../icon_label.dart';

class DetailsPaneSequence extends StatefulWidget {
  const DetailsPaneSequence({super.key, required this.sequence});

  final Sequence sequence;

  @override
  State<DetailsPaneSequence> createState() => _DetailsPaneSequenceState();
}

class _DetailsPaneSequenceState extends State<DetailsPaneSequence>
    with AutomaticKeepAliveClientMixin<DetailsPaneSequence> {
  late String title;
  late String description;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  late DateTime startDate;
  late DateTime endDate;

  @override
  void initState() {
    super.initState();

    title = widget.sequence.title;
    description = widget.sequence.description ?? '';
    startDate = widget.sequence.beginDate;
    endDate = widget.sequence.endDate;

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
