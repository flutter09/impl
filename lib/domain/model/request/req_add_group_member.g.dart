// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_add_group_member.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqAddGroupMember _$ReqAddGroupMemberFromJson(Map<String, dynamic> json) =>
    ReqAddGroupMember(
      groupId: json['group_id'] as String,
      userdetails:
          ReqGroupMember.fromJson(json['user_details'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ReqAddGroupMemberToJson(ReqAddGroupMember instance) =>
    <String, dynamic>{
      'group_id': instance.groupId,
      'user_details': instance.userdetails,
    };
