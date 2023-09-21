// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_register_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqRegisterGroup _$ReqRegisterGroupFromJson(Map<String, dynamic> json) =>
    ReqRegisterGroup(
      projectId: json['project_id'] as String?,
      name: json['name'] as String?,
      groupId: json['group_id'] as String?,
      description: json['description'] as String?,
      groupMembers: (json['group_members'] as List<dynamic>?)
          ?.map((e) => ReqGroupMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReqRegisterGroupToJson(ReqRegisterGroup instance) =>
    <String, dynamic>{
      'project_id': instance.projectId,
      'name': instance.name,
      'group_id': instance.groupId,
      'description': instance.description,
      'group_members': instance.groupMembers,
    };

ReqGroupMember _$ReqGroupMemberFromJson(Map<String, dynamic> json) =>
    ReqGroupMember(
      userId: json['user_id'] as String?,
      userName: json['user_name'] as String?,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$ReqGroupMemberToJson(ReqGroupMember instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'role': instance.role,
    };
