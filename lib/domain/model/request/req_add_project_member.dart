import 'package:json_annotation/json_annotation.dart';

part 'req_add_project_member.g.dart';

@JsonSerializable()
class ReqAddProjectMember {
  @JsonKey(name: 'project_id')
  final String projectId;

  @JsonKey(name: 'user_details')
  final UserDetails userDetails;

  ReqAddProjectMember({
    required this.projectId,
    required this.userDetails,
  });

  factory ReqAddProjectMember.fromJson(Map<String, dynamic> json) => _$ReqAddProjectMemberFromJson(json);
  Map<String, dynamic> toJson() => _$ReqAddProjectMemberToJson(this);
}

@JsonSerializable()
class UserDetails {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'user_name')
  final String userName;

  @JsonKey(name: 'role')
  final String role;

  UserDetails({
    required this.userId,
    required this.userName,
    required this.role,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
