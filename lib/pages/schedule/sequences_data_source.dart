import 'package:cpm/models/sequence/sequence.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SequencesDataSource extends CalendarDataSource {
  SequencesDataSource(List<Sequence> sequences) {
    appointments = sequences;
  }

  @override
  DateTime getStartTime(int index) {
    return (appointments![index] as Sequence).startDate!;
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments![index] as Sequence).endDate!;
  }

  @override
  String getSubject(int index) {
    return (appointments![index] as Sequence).getTitle;
  }

  @override
  String getNotes(int index) {
    return (appointments![index] as Sequence).getDescription;
  }

  @override
  String getLocation(int index) {
    return ''; // TODO add location
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}
