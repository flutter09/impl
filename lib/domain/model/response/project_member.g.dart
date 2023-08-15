// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProjectMember _$ProjectMemberFromJson(Map<String, dynamic> json) =>
    ProjectMember(
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      role: json['role'] as int,
      roles: json['roles'] as int,
    );

Map<String, dynamic> _$ProjectMemberToJson(ProjectMember instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'role': instance.role,
      'roles': instance.roles,
    };
