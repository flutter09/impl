import 'package:chat_application/domain/model/request/req_register_group.dart';
import 'package:json_annotation/json_annotation.dart';

part 'req_add_group_member.g.dart';

@JsonSerializable()
class ReqAddGroupMember {
  @JsonKey(name: 'group_id')
  final String groupId;

  @JsonKey(name: 'user_details')
  final ReqGroupMember userdetails;

  ReqAddGroupMember({
    required this.groupId,
    required this.userdetails,
  });

  factory ReqAddGroupMember.fromJson(Map<String, dynamic> json) => _$ReqAddGroupMemberFromJson(json);
  Map<String, dynamic> toJson() => _$ReqAddGroupMemberToJson(this);
}