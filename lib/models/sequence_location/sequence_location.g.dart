// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SequenceLocation _$SequenceLocationFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SequenceLocation',
      json,
      ($checkedConvert) {
        final val = SequenceLocation(
          id: $checkedConvert('id', (v) => v as int?),
          sequence: $checkedConvert('sequence', (v) => v as int),
          location: $checkedConvert('location', (v) => v as int),
        );
        return val;
      },
    );

Map<String, dynamic> _$SequenceLocationToJson(SequenceLocation instance) => <String, dynamic>{
      'sequence': instance.sequence,
      'location': instance.location,
    };
