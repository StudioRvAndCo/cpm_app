import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../models/episode.dart';
import '../models/event.dart';
import '../models/project.dart';
import '../models/sequence.dart';

enum View { month, week, day }

final GlobalKey<MonthViewState<Event>> calendarMonthKey = GlobalKey<MonthViewState<Event>>();
final GlobalKey<WeekViewState<Event>> calendarWeekKey = GlobalKey<WeekViewState<Event>>();
final GlobalKey<DayViewState<Event>> calendarDayKey = GlobalKey<DayViewState<Event>>();

class Planning extends StatefulWidget {
  const Planning({super.key, required this.project});

  final Project project;

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> with TickerProviderStateMixin {
  final List<CalendarEventData<Event>> _events = <CalendarEventData<Event>>[];
  View view = View.week;

  @override
  void initState() {
    super.initState();

    if (widget.project.episodes != null) {
      for (final Episode episode in widget.project.episodes!) {
        for (final Sequence sequence in episode.sequences) {
          _events.add(CalendarEventData<Event>(
              event: Event(title: sequence.title, description: sequence.description ?? ''),
              title: sequence.title,
              date: sequence.startDate,
              startTime: sequence.startDate,
              endTime: sequence.endDate));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    CalendarControllerProvider.of<Event>(context).controller.addAll(_events);

    switch (view) {
      case View.month:
        return Expanded(child: _buildMonthView());
      case View.week:
        return Expanded(child: _buildWeekView());
      case View.day:
        return Expanded(child: _buildDayView());
    }
  }

  HeaderStyle _buildHeader() {
    return HeaderStyle(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        leftIcon: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  switch (view) {
                    case View.month:
                      calendarMonthKey.currentState?.previousPage();
                      break;
                    case View.week:
                      calendarWeekKey.currentState?.previousPage();
                      break;
                    case View.day:
                      calendarDayKey.currentState?.previousPage();
                      break;
                  }
                },
                icon: const Icon(Icons.chevron_left)),
            const Padding(padding: EdgeInsets.only(right: 8)),
            IconButton(
                onPressed: () {
                  switch (view) {
                    case View.month:
                      calendarMonthKey.currentState?.nextPage();
                      break;
                    case View.week:
                      calendarWeekKey.currentState?.nextPage();
                      break;
                    case View.day:
                      calendarDayKey.currentState?.nextPage();
                      break;
                  }
                },
                icon: const Icon(Icons.chevron_right))
          ],
        ),
        rightIcon: DropdownButton<View>(
          focusColor: Colors.transparent,
          value: view,
          items: <DropdownMenuItem<View>>[
            DropdownMenuItem<View>(
                value: View.month,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_view_month),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    Text('planning.date.month.upper'.tr()),
                  ],
                )),
            DropdownMenuItem<View>(
                value: View.week,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_view_week),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    Text('planning.date.week.upper'.tr()),
                  ],
                )),
            DropdownMenuItem<View>(
                value: View.day,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_view_day),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    Text('planning.date.day.upper'.tr()),
                  ],
                ))
          ],
          onChanged: (View? newView) {
            setState(() {
              view = newView!;
            });
          },
        ));
  }

  LayoutBuilder _buildMonthView() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return MonthView<Event>(
        key: calendarMonthKey,
        headerStyle: _buildHeader(),
        minMonth: widget.project.startDate,
        maxMonth: widget.project.endDate,
        initialMonth: DateTime.now(),
        onPageChange: (DateTime date, int pageIndex) => print('$date, $pageIndex'),
        onCellTap: (List<CalendarEventData<Object?>> events, DateTime date) {
          print(events);
        },
        onEventTap: (CalendarEventData<Object?> event, DateTime date) => print(event),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }

  LayoutBuilder _buildWeekView() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return WeekView<Event>(
        key: calendarWeekKey,
        headerStyle: _buildHeader(),
        minDay: widget.project.startDate,
        maxDay: widget.project.endDate,
        initialDay: DateTime.now(),
        eventArranger: const SideEventArranger<Event>(),
        onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) => print(events),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }

  LayoutBuilder _buildDayView() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return DayView<Event>(
        key: calendarDayKey,
        headerStyle: _buildHeader(),
        minDay: widget.project.startDate,
        maxDay: widget.project.endDate,
        initialDay: DateTime.now(),
        eventArranger: const SideEventArranger<Event>(),
        onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) => print(events),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }
}
