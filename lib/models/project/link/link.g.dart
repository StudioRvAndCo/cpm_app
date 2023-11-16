// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Link',
      json,
      ($checkedConvert) {
        final val = Link(
          id: $checkedConvert('id', (v) => v as int?),
          project: $checkedConvert('project', (v) => v as int?),
          index: $checkedConvert('index', (v) => v as int?),
          label: $checkedConvert('label', (v) => v as String?),
          url: $checkedConvert('url', (v) => v as String?),
        );
        return val;
      },
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'project': instance.project,
      'index': instance.index,
      'label': instance.label,
      'url': instance.url,
    };
