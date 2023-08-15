import 'package:json_annotation/json_annotation.dart';
import 'project_member.dart';

part 'project.g.dart';

@JsonSerializable()
class Project {
  final String name;
  final String description;

  @JsonKey(name: 'project_members')
  final List<ProjectMember> projectMembers;

  Project({
    required this.name,
    required this.description,
    required this.projectMembers,
  });

  factory Project.fromJson(Map<String, dynamic> json) =>
      _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);
}
