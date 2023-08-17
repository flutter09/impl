// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_add_project_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqAddProjectMember _$ReqAddProjectMemberFromJson(Map<String, dynamic> json) =>
    ReqAddProjectMember(
      projectId: json['project_id'] as String,
      userDetails:
          UserDetails.fromJson(json['user_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReqAddProjectMemberToJson(
        ReqAddProjectMember instance) =>
    <String, dynamic>{
      'project_id': instance.projectId,
      'user_details': instance.userDetails,
    };

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails(
      userId: json['user_id'] as String,
      userName: json['user_name'] as String,
      role: json['role'] as String,
    );

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'user_name': instance.userName,
      'role': instance.role,
    };
