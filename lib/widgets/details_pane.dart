import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPane extends StatefulWidget {
  const DetailsPane({super.key});

  @override
  State<DetailsPane> createState() => _DetailsPaneState();
}

class _DetailsPaneState extends State<DetailsPane> with AutomaticKeepAliveClientMixin<DetailsPane> {
  String title = '';
  String description = '';
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime firstDate = DateTime.now();
  DateTime lastDate = DateTime.now().add(const Duration(days: 1));
  String dateText = '';

  @override
  void initState() {
    titleController.text = title;
    descriptionController.text = description;
    updateDateText();
    return super.initState();
  }

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

  void updateDateText() {
    final String firstText = DateFormat.yMd(Intl.systemLocale).format(firstDate);
    final String lastText = DateFormat.yMd(Intl.systemLocale).format(lastDate);
    setState(() {
      dateText = '$firstText - $lastText';
    });
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
              decoration: const InputDecoration.collapsed(hintText: 'Title'),
              controller: titleController,
              onChanged: setTitle,
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              style: Theme.of(context).textTheme.bodyMedium,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Description'),
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
                    initialDateRange: DateTimeRange(start: firstDate, end: lastDate), //get today's date
                  firstDate:DateTime(2000), //DateTime.now() - not to allow to choose before today.
                  lastDate: DateTime(2101)
                );
                if (pickedRange != null) {
                  firstDate = pickedRange.start;
                  lastDate = pickedRange.end;
                  updateDateText();
                }
              },
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: <Widget>[
                  const Icon(Icons.event_outlined),
                  const SizedBox(width: 8),
                  Text(dateText, style: TextStyle(color: Theme.of(context).colorScheme.primary),)
                ],
              ),
            )
          ],
        ));
  }
  
  @override
  bool get wantKeepAlive => true;
}
