// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shot _$ShotFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Shot',
      json,
      ($checkedConvert) {
        final val = Shot(
          id: $checkedConvert('id', (v) => v as int),
          sequence: $checkedConvert('sequence', (v) => v as int),
          index: $checkedConvert('index', (v) => v as int),
          number: $checkedConvert('number', (v) => v as int),
          value: $checkedConvert('value', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          completed: $checkedConvert('completed', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$ShotToJson(Shot instance) => <String, dynamic>{
      'sequence': instance.sequence,
      'index': instance.index,
      'value': instance.value,
      'description': instance.description,
      'completed': instance.completed,
    };
