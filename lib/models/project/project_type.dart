import 'package:cpm/utils/constants/constants.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'name')
enum ProjectType {
  unknown('Unknown'),
  movie('Movie'),
  series("Series"),
  ;

  final String name;

  const ProjectType(this.name);

  String get label {
    switch (this) {
      case ProjectType.movie:
        return localizations.projects_movie;
      case ProjectType.series:
        return localizations.projects_series;
      case ProjectType.unknown:
        throw Error();
    }
  }
}
