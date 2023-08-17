// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResProject _$ResProjectFromJson(Map<String, dynamic> json) => ResProject(
      id: json['_id'] as String,
      name: json['name'] as String,
      groupsId:
          (json['groups_id'] as List<dynamic>).map((e) => e as String).toList(),
      image: json['image'] as String,
      description: json['description'] as String,
      projectMembers: (json['project_members'] as List<dynamic>)
          .map((e) => ResProjectMember.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdBy: json['create_by'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      uniqueId: json['unique_id'] as int,
      version: json['__v'] as int,
    );

Map<String, dynamic> _$ResProjectToJson(ResProject instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'groups_id': instance.groupsId,
      'image': instance.image,
      'description': instance.description,
      'project_members': instance.projectMembers,
      'create_by': instance.createdBy,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'unique_id': instance.uniqueId,
      '__v': instance.version,
    };

ResProjectMember _$ResProjectMemberFromJson(Map<String, dynamic> json) =>
    ResProjectMember(
      userId: json['user_id'] as String,
      role: json['role'] as String,
      id: json['_id'] as String,
    );

Map<String, dynamic> _$ResProjectMemberToJson(ResProjectMember instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'role': instance.role,
      '_id': instance.id,
    };
