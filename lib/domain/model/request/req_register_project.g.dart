// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_register_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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
