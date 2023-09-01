// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Project',
      json,
      ($checkedConvert) {
        final val = Project(
          id: $checkedConvert('id', (v) => v as int),
          projectType: $checkedConvert('project_type', (v) => $enumDecode(_$ProjectTypeEnumMap, v)),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          startDate: $checkedConvert('start_date', (v) => v == null ? null : DateTime.parse(v as String)),
          endDate: $checkedConvert('end_date', (v) => v == null ? null : DateTime.parse(v as String)),
          director: $checkedConvert('director', (v) => v as String?),
          writer: $checkedConvert('writer', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {'projectType': 'project_type', 'startDate': 'start_date', 'endDate': 'end_date'},
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'project_type': _$ProjectTypeEnumMap[instance.projectType]!,
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'director': instance.director,
      'writer': instance.writer,
    };

const _$ProjectTypeEnumMap = {
  ProjectType.unknown: 'Unknown',
  ProjectType.movie: 'Movie',
  ProjectType.series: 'Series',
};
