import 'package:json_annotation/json_annotation.dart';

import '../response/res_project.dart';


class ReqRegisterProject {
  final String name;

  final String description;

  final List<ProjectMember> projectMembers;

  ReqRegisterProject({
    required this.name,
    required this.description,
    required this.projectMembers,
  });

  factory ReqRegisterProject.fromJson(Map<String, dynamic> json) => _$ReqRegisterProjectFromJson(json);

  Map<String, dynamic> toJson() => {
      'name': name,
      'description': description,
      'project_members': projectMembers.map((member) => member.toJson()).toList(),
  };
}

ReqRegisterProject _$ReqRegisterProjectFromJson(Map<String, dynamic> json) =>
    ReqRegisterProject(
      name: json['name'] as String,
      description: json['description'] as String,
      projectMembers: (json['project_members'] as List<dynamic>)
          .map((e) => ProjectMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

