import 'package:chat_application/domain/model/request/req_register_group.dart';


class ReqAddGroupMember {
  final String groupId;

  final ReqGroupMember userdetails;

  ReqAddGroupMember({
    required this.groupId,
    required this.userdetails,
  });

  factory ReqAddGroupMember.fromJson(Map<String, dynamic> json) => _$ReqAddGroupMemberFromJson(json);
  Map<String, dynamic> toJson() => _$ReqAddGroupMemberToJson(this);
}

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
