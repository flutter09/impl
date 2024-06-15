import 'package:json_annotation/json_annotation.dart';


class ReqAddProjectMember {
  final String projectId;
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
