import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../models/project.dart';
import '../models/sequence.dart';

enum View { month, week, day }

final GlobalKey<MonthViewState> calendarKey = GlobalKey<MonthViewState>();

class Planning extends StatefulWidget {
  const Planning({super.key, required this.project});

  final Project project;

  @override
  State<Planning> createState() => _PlanningState();
}

class _PlanningState extends State<Planning> with TickerProviderStateMixin {
  final List<CalendarEventData<String>> _events = <CalendarEventData<String>>[];
  View view = View.month;

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
          children: [
            IconButton(
                onPressed: () {
                  calendarKey.currentState?.previousPage();
                },
                icon: const Icon(Icons.chevron_left)),
            const Padding(padding: EdgeInsets.only(right: 8)),
            IconButton(
                onPressed: () {
                  calendarKey.currentState?.nextPage();
                },
                icon: const Icon(Icons.chevron_right))
          ],
        ),
        rightIcon: DropdownButton<View>(
          focusColor: Colors.transparent,
          value: view,
          items: [
            DropdownMenuItem<View>(
                value: View.month,
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.calendar_view_month),
                    Padding(padding: EdgeInsets.only(right: 8)),
                    Text('Month'),
                  ],
                )),
            DropdownMenuItem<View>(
                value: View.week,
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.calendar_view_week),
                    Padding(padding: EdgeInsets.only(right: 8)),
                    Text('Week'),
                  ],
                )),
            DropdownMenuItem<View>(
                value: View.day,
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.calendar_view_day),
                    Padding(padding: EdgeInsets.only(right: 8)),
                    Text('Day'),
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
      return MonthView(
        key: calendarKey,
        headerStyle: _buildHeader(),
        minMonth: widget.project.beginDate,
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
      return WeekView(
        headerStyle: _buildHeader(),
        minDay: widget.project.beginDate,
        maxDay: widget.project.endDate,
        initialDay: DateTime.now(),
        eventArranger: const SideEventArranger(),
        onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) => print(events),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }

  LayoutBuilder _buildDayView() {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return DayView(
        headerStyle: _buildHeader(),
        minDay: widget.project.beginDate,
        maxDay: widget.project.endDate,
        initialDay: DateTime.now(),
        eventArranger: const SideEventArranger(),
        onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) => print(events),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }
}
