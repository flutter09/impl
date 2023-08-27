import 'package:json_annotation/json_annotation.dart';

part 'res_project.g.dart';

@JsonSerializable()
class ResProject {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'groups_id')
  final List<String>? groupsId;

  @JsonKey(name: 'image')
  String? image;

  @JsonKey(name: 'description')
  String? description;

  @JsonKey(name: 'project_members')
  final List<ResProjectMember>? projectMembers;

  @JsonKey(name: 'create_by')
  final String? createdBy;

  @JsonKey(name: 'createdAt')
  final String? createdAt;

  @JsonKey(name: 'updatedAt')
  final String? updatedAt;

  @JsonKey(name: 'unique_id')
  final int? uniqueId;

  @JsonKey(name: '__v')
  final int? version;

  ResProject({
    required this.id,
    required this.name,
    required this.groupsId,
    required this.image,
    required this.description,
    required this.projectMembers,
    required this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    required this.uniqueId,
    required this.version,
  });

  factory ResProject.fromJson(Map<String, dynamic> json) => _$ResProjectFromJson(json);
  Map<String, dynamic> toJson() => _$ResProjectToJson(this);
}

@JsonSerializable()
class ResProjectMember {
  @JsonKey(name: 'user_id')
  final String? userId;

  @JsonKey(name: 'role')
  final String? role;

  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(ignore: true)
  String? customName;

  @JsonKey(ignore: true)
  String? customRole;

  ResProjectMember({
    required this.userId,
    required this.role,
    required this.id,
    this.customName,
    this.customRole
  });

  factory ResProjectMember.fromJson(Map<String, dynamic> json) => _$ResProjectMemberFromJson(json);
  Map<String, dynamic> toJson() => _$ResProjectMemberToJson(this);
}
