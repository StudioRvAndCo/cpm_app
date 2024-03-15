// ignore_for_file: must_be_immutable

import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/shot/shot_value.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:excel/excel.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shot.g.dart';

@JsonSerializable()
class Shot extends BaseModel {
  int? sequence;
  ShotValue? value;
  String? description;
  bool completed;

  Shot({
    super.id,
    super.index,
    this.sequence,
    this.value = ShotValue.other,
    this.description,
    this.completed = false,
  });

  factory Shot.fromJson(Map<String, dynamic> json) => _$ShotFromJson(json);

  factory Shot.parseExcel(int sequenceId, List<Data?> row, String index) {
    final description = StringBuffer();
    for (final data in row.sublist(2)) {
      if (data != null && data.value != null) {
        description.write(data.value);
        description.write('\n\n');
      }
    }

    return Shot(
      sequence: sequenceId,
      index: index,
      description: description.toString(),
      value: ShotValue.fromName(row[1]?.value.toString()),
    );
  }

  String get getDescription {
    return description == null || description!.isEmpty ? localizations.projects_no_description : description!;
  }

  String get getValue => value?.label ?? localizations.projects_no_value;

  @override
  Map<String, dynamic> toJson() => _$ShotToJson(this)
    ..addAll({
      'index': index,
    });

  @override
  Map<String, dynamic> toJsonCache() {
    return toJsonCacheBase(_$ShotToJson(this));
  }
}
