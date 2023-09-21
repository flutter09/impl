// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResGroupMember _$ResGroupMemberFromJson(Map<String, dynamic> json) =>
    ResGroupMember(
      userId: json['user_id'] as String?,
      role: json['role'] as String?,
      id: json['_id'] as String?,
    );

Map<String, dynamic> _$ResGroupMemberToJson(ResGroupMember instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'role': instance.role,
      '_id': instance.id,
    };

ResGroup _$ResGroupFromJson(Map<String, dynamic> json) => ResGroup(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      groupMembers: (json['group_members'] as List<dynamic>?)
          ?.map((e) => ResGroupMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      projectId: json['project_id'] as String?,
      createdBy: json['create_by'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      uniqueId: json['unique_id'] as int?,
    );
