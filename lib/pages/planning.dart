import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/project.dart';
import '../models/sequence.dart';

class Planning extends StatefulWidget {
  const Planning({super.key, required this.project});

  final Project project;

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> with TickerProviderStateMixin {
  final List<CalendarEventData<String>> _events = <CalendarEventData<String>>[];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

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

    return Expanded(
      child: Column(
        children: [
          Wrap(
            children: [
              Material(
                color: Theme.of(context).colorScheme.surface,
                child: TabBar(
                  controller: _tabController,
                  tabs: <Tab>[
                    Tab(
                        icon: const Icon(Icons.calendar_view_month),
                        text: 'planning.date.month.upper'.tr()),
                    Tab(
                        icon: const Icon(Icons.calendar_view_week),
                        text: 'planning.date.week.upper'.tr()),
                    Tab(
                        icon: const Icon(Icons.calendar_view_day),
                        text: 'planning.date.day.upper'.tr())
                  ],
                ),
              )
            ],
          ),
          Expanded(
              child: TabBarView(controller: _tabController, children: [
            _buildMonthView(),
            _buildWeekView(),
            _buildDayView()
          ])),
        ],
      ),
    );
  }

  LayoutBuilder _buildMonthView() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return MonthView(
        headerStyle: HeaderStyle(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.surface)),
        minMonth: widget.project.beginDate,
        maxMonth: widget.project.endDate,
        initialMonth: DateTime.now(),
        onPageChange: (DateTime date, int pageIndex) =>
            print("$date, $pageIndex"),
        onCellTap: (List<CalendarEventData<Object?>> events, DateTime date) {
          print(events);
        },
        onEventTap: (CalendarEventData<Object?> event, DateTime date) =>
            print(event),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }

  LayoutBuilder _buildWeekView() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return WeekView(
        headerStyle: HeaderStyle(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.surface)),
        minDay: widget.project.beginDate,
        maxDay: widget.project.endDate,
        initialDay: DateTime.now(),
        eventArranger: const SideEventArranger(),
        onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) =>
            print(events),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }

  LayoutBuilder _buildDayView() {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return DayView(
        headerStyle: HeaderStyle(
            decoration:
                BoxDecoration(color: Theme.of(context).colorScheme.surface)),
        minDay: widget.project.beginDate,
        maxDay: widget.project.endDate,
        initialDay: DateTime.now(),
        eventArranger: const SideEventArranger(),
        onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) =>
            print(events),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }
}
