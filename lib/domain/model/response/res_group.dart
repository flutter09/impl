import 'package:json_annotation/json_annotation.dart';
import 'package:chat_application/utils/utils.dart';

part 'res_group.g.dart';

@JsonSerializable()
class ResGroupMember {
  @JsonKey(name: 'user_id')
  final String? userId;
  final String? role;
  @JsonKey(name: '_id')
  final String? id;

  ResGroupMember({
    required this.userId,
    required this.role,
    required this.id,
  });

  factory ResGroupMember.fromJson(Map<String, dynamic> json) =>
      _$ResGroupMemberFromJson(json);
  Map<String, dynamic> toJson() => _$ResGroupMemberToJson(this);
}

@JsonSerializable(createToJson: false)
class ResGroup {
  @JsonKey(name: '_id')
  final String? id;
  final String? name;
  @JsonKey(name: 'group_members' ,toJson: _$ResGroupMemberToJson)
  final List<ResGroupMember>? groupMembers;
  @JsonKey(name: 'project_id')
  final String? projectId;
  @JsonKey(name: 'create_by')
  final String? createdBy;
  @JsonKey(
    name: 'createdAt'
  )
  final DateTime? createdAt;
  @JsonKey(
    name: 'updatedAt'
  )
  final DateTime? updatedAt;
  @JsonKey(name: 'unique_id')
  final int? uniqueId;

  ResGroup({
    required this.id,
    required this.name,
    required this.groupMembers,
    required this.projectId,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.uniqueId,
  });

  factory ResGroup.fromJson(Map<String, dynamic> json) =>
      _$ResGroupFromJson(json);
  Map<String, dynamic> toJson() => _$ResGroupToJson(this);

  Map<String, dynamic> _$ResGroupToJson(ResGroup instance) => <String, dynamic>{
    '_id': instance.id,
    'name': instance.name,
    'group_members': instance.groupMembers?.map((e) => e.toJson()).toList(),
    'project_id': instance.projectId,
    'create_by': instance.createdBy,
    'createdAt': instance.createdAt?.toIso8601String(),
    'updatedAt': instance.updatedAt?.toIso8601String(),
    'unique_id': instance.uniqueId,
  };
}


