import 'package:cpm/pages/schedule/appointment_tile.dart';
import 'package:cpm/pages/schedule/sequences_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../models/sequence/sequence.dart';
import '../../providers/sequences/sequences.dart';
import '../../utils/constants_globals.dart';

class Schedule extends ConsumerStatefulWidget {
  const Schedule({super.key});

  @override
  ConsumerState<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends ConsumerState<Schedule> {
  final CalendarController _calendarController = CalendarController();

  Widget _getAppointmentBuilder(BuildContext _, CalendarAppointmentDetails details) {
    return AppointmentTile(sequence: (details.appointments.first));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: ref.watch(sequencesProvider).when(
          data: (List<Sequence> sequences) {
            return SfCalendar(
              controller: _calendarController,
              dataSource: SequencesDataSource(sequences),
              firstDayOfWeek: 1,
              showNavigationArrow: true,
              showTodayButton: true,
              view: CalendarView.day,
              allowedViews: const [
                CalendarView.schedule,
                CalendarView.day,
                CalendarView.week,
              ],
              appointmentBuilder: _getAppointmentBuilder,
            );
          },
          error: (Object error, StackTrace stackTrace) {
            return requestPlaceholderError;
          },
          loading: () {
            return requestPlaceholderLoading;
          },
        ),
      ),
    );
  }
}
