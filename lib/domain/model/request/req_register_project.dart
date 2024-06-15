import 'package:json_annotation/json_annotation.dart';


class ReqRegisterProject {
  final String name;

  final String description;

  final List<ReqProjectMember> projectMembers;

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

@JsonSerializable()
class ReqProjectMember {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'user_name')
  final String userName;

  @JsonKey(name: 'role')
  final String role;

  ReqProjectMember({
    required this.userId,
    required this.userName,
    required this.role,
  });

  factory ReqProjectMember.fromJson(Map<String, dynamic> json) => _$ReqProjectMemberFromJson(json);

  Map<String, dynamic> toJson() => _$ReqProjectMemberToJson(this);
}
ReqRegisterProject _$ReqRegisterProjectFromJson(Map<String, dynamic> json) =>
    ReqRegisterProject(
      name: json['name'] as String,
      description: json['description'] as String,
      projectMembers: (json['project_members'] as List<dynamic>)
          .map((e) => ReqProjectMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

ReqProjectMember _$ReqProjectMemberFromJson(Map<String, dynamic> json) =>
    ReqProjectMember(
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$ReqProjectMemberToJson(ReqProjectMember instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'role': instance.role,
    };
