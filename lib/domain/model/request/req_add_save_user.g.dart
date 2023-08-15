// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_add_save_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqAddSaveUser _$ReqAddSaveUserFromJson(Map<String, dynamic> json) =>
    ReqAddSaveUser(
      userId: json['user_id'] as String,
      userName: json['userName'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
      roles: (json['roles'] as List<dynamic>).map((e) => e as int).toList(),
    );

Map<String, dynamic> _$ReqAddSaveUserToJson(ReqAddSaveUser instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'userName': instance.userName,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
      'roles': instance.roles,
    };
