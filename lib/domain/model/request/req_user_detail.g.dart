// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_user_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqUserDetail _$ReqUserDetailFromJson(Map<String, dynamic> json) =>
    ReqUserDetail(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$ReqUserDetailToJson(ReqUserDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
    };
