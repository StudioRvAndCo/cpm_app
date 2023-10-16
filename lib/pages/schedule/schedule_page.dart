import 'package:cpm/common/request_placeholder.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/pages/schedule/appointment_tile.dart';
import 'package:cpm/pages/schedule/sequences_data_source.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _ScheduleState();
}

class _ScheduleState extends ConsumerState<SchedulePage> {
  final CalendarController _calendarController = CalendarController();

  Widget _getAppointmentBuilder(BuildContext _, CalendarAppointmentDetails details) {
    return AppointmentTile(sequence: details.appointments.first as Sequence);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(sequencesProvider).when(
      data: (List<Sequence> sequences) {
        return SfCalendar(
          controller: _calendarController,
          dataSource: SequencesDataSource(sequences),
          firstDayOfWeek: 1,
          showNavigationArrow: true,
          showTodayButton: true,
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
    );
  }
}
