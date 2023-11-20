// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sequence _$SequenceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Sequence',
      json,
      ($checkedConvert) {
        final val = Sequence(
          id: $checkedConvert('id', (v) => v as int?),
          episode: $checkedConvert('episode', (v) => v as int?),
          index: $checkedConvert('index', (v) => v as int?),
          number: $checkedConvert('number', (v) => v as int? ?? -1),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          startDate: $checkedConvert('start_date', (v) => v == null ? null : DateTime.parse(v as String)),
          endDate: $checkedConvert('end_date', (v) => v == null ? null : DateTime.parse(v as String)),
          shotsTotal: $checkedConvert('shots_total', (v) => v as int?),
          shotsCompleted: $checkedConvert('shots_completed', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'startDate': 'start_date',
        'endDate': 'end_date',
        'shotsTotal': 'shots_total',
        'shotsCompleted': 'shots_completed'
      },
    );

Map<String, dynamic> _$SequenceToJson(Sequence instance) => <String, dynamic>{
      'episode': instance.episode,
      'index': instance.index,
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
    };
