import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NewSequenceDialog extends StatefulWidget {
  const NewSequenceDialog({super.key, required this.locations});

  final List<String> locations;

  @override
  State<StatefulWidget> createState() => _NewSequenceDialogState();
}

class _NewSequenceDialogState extends State<NewSequenceDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late final List<String> locations;
  DateTimeRange? dates;
  String? selectedLocation;
  String dateText = '';

  @override
  void initState() {
    updateDateText();
    locations = widget.locations;
    return super.initState();
  }

  void updateDateText() {
    String res;
    if (dates != null) {
      final String firstText = DateFormat.yMd(Intl.systemLocale).format(dates!.start);
      final String lastText = DateFormat.yMd(Intl.systemLocale).format(dates!.end);
      res = '$firstText - $lastText';
    } else {
      res = 'dates_dialog'.tr();
    }
    setState(() {
      dateText = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(6.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Text>[
                  Text('${'new.fem.upper'.tr()} ${'sequences.sequence.lower'.plural(1)}'),
                  Text(
                    '${'add.upper'.tr()} ${'articles.a.fem.lower'.tr()} ${'new.fem.lower'.tr()} ${'sequences.sequence.lower'.plural(1)}.',
                    style: const TextStyle(fontSize: 12),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextField(
                    maxLength: 64,
                    controller: titleController,
                    decoration: InputDecoration(
                        labelText: 'attributes.title.upper'.tr(), border: const OutlineInputBorder(), isDense: true),
                    autofocus: true,
                    onEditingComplete: submit,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextFormField(
                    maxLength: 280,
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: InputDecoration(
                        labelText: 'attributes.description.upper'.tr(),
                        border: const OutlineInputBorder(),
                        isDense: true),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final DateTimeRange? picked = await showDateRangePicker(
                          context: context,
                          firstDate: DateTime(1970),
                          lastDate: DateTime(3000),
                          initialDateRange: dates);
                      if (picked != null) {
                        dates = DateTimeRange(start: picked.start, end: picked.end);
                        updateDateText();
                      }
                    },
                    icon: const Icon(Icons.calendar_month),
                    label: Text(dateText),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  hint: Text('attributes.position.upper'.tr()),
                  items: locations.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: selectedLocation,
                  onChanged: (String? value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  decoration:
                      InputDecoration(labelText: selectedLocation, border: const OutlineInputBorder(), isDense: true),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancel.upper'.tr())),
                  TextButton(onPressed: submit, child: Text('confirm.upper'.tr()))
                ],
              )
            ]),
          ),
        )
      ],
    );
  }

  void submit() {
    Navigator.pop(context);
  }
}
