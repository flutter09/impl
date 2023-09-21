import 'package:json_annotation/json_annotation.dart';

part 'req_register_group.g.dart';

@JsonSerializable()
class ReqRegisterGroup {
  @JsonKey(name: 'project_id')
  final String? projectId;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'group_id')
  final String? groupId;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'group_members')
  final List<ReqGroupMember>? groupMembers;

  ReqRegisterGroup({
    required this.projectId,
    required this.name,
    required this.groupId,
    required this.description,
    required this.groupMembers,
  });

  factory ReqRegisterGroup.fromJson(Map<String, dynamic> json) => _$ReqRegisterGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ReqRegisterGroupToJson(this);
}

@JsonSerializable()
class ReqGroupMember {
  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'user_name')
  final String? userName;

  @JsonKey(name: 'role')
  final String? role;

  ReqGroupMember({
    required this.userId,
    required this.userName,
    required this.role,
  });

  factory ReqGroupMember.fromJson(Map<String, dynamic> json) => _$ReqGroupMemberFromJson(json);
  Map<String, dynamic> toJson() => _$ReqGroupMemberToJson(this);
}
