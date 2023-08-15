import 'package:json_annotation/json_annotation.dart';

part 'project_member.g.dart';

@JsonSerializable()
class ProjectMember {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'user_name')
  final String userName;

  final int role;

  @JsonKey(name: 'roles')
  final int roles;

  ProjectMember({
    required this.userId,
    required this.userName,
    required this.role,
    required this.roles,
  });

  factory ProjectMember.fromJson(Map<String, dynamic> json) =>
      _$ProjectMemberFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectMemberToJson(this);
}
