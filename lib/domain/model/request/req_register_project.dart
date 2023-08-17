import 'package:json_annotation/json_annotation.dart';

part 'req_register_project.g.dart';

@JsonSerializable()
class ReqRegisterProject {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'project_members')
  final List<ReqProjectMember> projectMembers;

  ReqRegisterProject({
    required this.name,
    required this.description,
    required this.projectMembers,
  });

  factory ReqRegisterProject.fromJson(Map<String, dynamic> json) => _$ReqRegisterProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ReqRegisterProjectToJson(this);
}

@JsonSerializable()
class ReqProjectMember {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'user_name')
  final String userName;

  @JsonKey(name: 'role')
  final int role;

  @JsonKey(name: 'roles')
  final int roles;

  ReqProjectMember({
    required this.userId,
    required this.userName,
    required this.role,
    required this.roles,
  });

  factory ReqProjectMember.fromJson(Map<String, dynamic> json) => _$ReqProjectMemberFromJson(json);

  Map<String, dynamic> toJson() => _$ReqProjectMemberToJson(this);
}
