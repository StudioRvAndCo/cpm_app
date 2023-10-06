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
          value: $checkedConvert('value', (v) => $enumDecodeNullable(_$ShotValueEnumMap, v)),
          description: $checkedConvert('description', (v) => v as String?),
          completed: $checkedConvert('completed', (v) => v as bool),
        );
        return val;
      },
    );

Map<String, dynamic> _$ShotToJson(Shot instance) => <String, dynamic>{
      'sequence': instance.sequence,
      'index': instance.index,
      'value': _$ShotValueEnumMap[instance.value],
      'description': instance.description,
      'completed': instance.completed,
    };

const _$ShotValueEnumMap = {
  ShotValue.full: 'full',
  ShotValue.mediumFull: 'medium_full',
  ShotValue.cowboy: 'cowboy',
  ShotValue.medium: 'medium',
  ShotValue.mediumCloseup: 'medium_closeup',
  ShotValue.closeup: 'closeup',
  ShotValue.extremeCloseup: 'extreme_closeup',
  ShotValue.insert: 'insert',
  ShotValue.sequence: 'sequence',
  ShotValue.landscape: 'landscape',
  ShotValue.drone: 'drone',
  ShotValue.other: 'other',
};
