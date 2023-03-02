import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../models/project.dart';
import '../models/sequence.dart';

class Planning extends StatefulWidget {
  const Planning({super.key, required this.project});

  final Project project;

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> {
  final List<CalendarEventData<String>> _events = <CalendarEventData<String>>[];

  @override
  void initState() {
    super.initState();

    for (final Sequence sequence in widget.project.sequences) {
      _events.add(CalendarEventData<String>(
          event: sequence.title,
          title: sequence.title,
          date: sequence.date,
          startTime: sequence.startTime,
          endTime: sequence.endTime));
    }
  }

  @override
  Widget build(BuildContext context) {
    CalendarControllerProvider.of(context).controller.addAll(_events);
    return const Expanded(
      child: MonthView(),
    );
  }
}
