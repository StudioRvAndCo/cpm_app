// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:cpm/utils/extensions/time_of_day_extensions.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sequence.g.dart';

@JsonSerializable()
class Sequence extends BaseModel {
  int? episode;
  int? index;
  @JsonKey(defaultValue: -1, includeToJson: false)
  int? number;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Location? location;

  Sequence({
    super.id,
    this.episode,
    this.index,
    this.number,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
  });

  factory Sequence.fromJson(Map<String, dynamic> json) => _$SequenceFromJson(json);

  String get getNumber => number.toString();

  String get getTitle {
    return title == null || title!.isEmpty ? localizations.projects_no_title : title!;
  }

  String get getDescription {
    return description == null || description!.isEmpty ? localizations.projects_no_description : description!;
  }

  DateTime get getDate => startDate ?? DateTime.now();

  TimeOfDay get getStartTime {
    return startDate != null ? TimeOfDay(hour: startDate!.hour, minute: startDate!.minute) : TimeOfDay.now();
  }

  TimeOfDay get getEndTime {
    return endDate != null ? TimeOfDay(hour: endDate!.hour, minute: endDate!.minute) : TimeOfDay.now().hourLater;
  }

  String? get dateText {
    if (startDate == null || endDate == null) return null;

    return '${startDate!.yMd} | ${startDate!.Hm} - ${endDate!.Hm}';
  }

  @override
  Map<String, dynamic> toJson() => _$SequenceToJson(this);

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(
      _$SequenceToJson(this)
        ..addAll({
          'number': number,
        }),
    );
  }
}
