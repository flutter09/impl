import 'package:chat_application/domain/model/response/res_user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'req_add_save_user.g.dart'; // This is the generated file, don't manually edit it

@JsonSerializable()
class ReqAddSaveUser {
  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'userName')
  final String userName;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'image')
  final String image;

  @JsonKey(name: 'roles')
  final List<int> roles;

  ReqAddSaveUser({
    required this.userId,
    required this.userName,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.roles,
  });

  factory ReqAddSaveUser.fromJson(Map<String, dynamic> json) =>
      _$ReqAddSaveUserFromJson(json);

  Map<String, dynamic> toJson() => _$ReqAddSaveUserToJson(this);

  UserSaveData toUserSaveData() => UserSaveData(
     userId : userId,
     userName : userName,
     name : name,
     email : email,
     phone : phone,
     image : image,
     roles : roles,
  );
}
