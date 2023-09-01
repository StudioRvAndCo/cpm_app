import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'name')
enum ProjectType {
  unknown('Unknown'),
  movie('Movie'),
  series('Series'),
  ;

  final String name;

  const ProjectType(this.name);
}
