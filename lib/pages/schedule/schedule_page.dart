import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/common/routes/router_route.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/pages/schedule/appointment_tile.dart';
import 'package:cpm/pages/schedule/sequences_data_source.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _ScheduleState();
}

class _ScheduleState extends ConsumerState<SchedulePage> {
  final CalendarController _calendarController = CalendarController();

  void _open(CalendarTapDetails? details) {
    if (details == null || details.appointments == null || details.appointments!.isEmpty) {
      return;
    }

    ref.read(currentSequenceProvider.notifier).set(details.appointments!.first as Sequence);
    context.push(RouterRoute.shots.fullPath!);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(sequencesProvider).when(
      data: (sequences) {
        return SfCalendar(
          controller: _calendarController,
          dataSource: SequencesDataSource(sequences),
          firstDayOfWeek: 1,
          showNavigationArrow: true,
          showTodayButton: true,
          view: CalendarView.schedule,
          allowedViews: const [
            CalendarView.schedule,
            CalendarView.day,
            CalendarView.week,
            CalendarView.month,
          ],
          appointmentBuilder: (context, details) {
            return AppointmentTile(details.appointments.first as Sequence);
          },
          onTap: _open,
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return CustomPlaceholder.error();
      },
      loading: () {
        return CustomPlaceholder.loading();
      },
    );
  }
}
