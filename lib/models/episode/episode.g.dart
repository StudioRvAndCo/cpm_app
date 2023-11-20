// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Episode',
      json,
      ($checkedConvert) {
        final val = Episode(
          id: $checkedConvert('id', (v) => v as int?),
          project: $checkedConvert('project', (v) => v as int?),
          index: $checkedConvert('index', (v) => v as int?),
          number: $checkedConvert('number', (v) => v as int?),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          director: $checkedConvert('director', (v) => v as String?),
          writer: $checkedConvert('writer', (v) => v as String?),
          shotsTotal: $checkedConvert('shots_total', (v) => v as int?),
          shotsCompleted: $checkedConvert('shots_completed', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {'shotsTotal': 'shots_total', 'shotsCompleted': 'shots_completed'},
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'project': instance.project,
      'index': instance.index,
      'title': instance.title,
      'description': instance.description,
      'director': instance.director,
      'writer': instance.writer,
    };
