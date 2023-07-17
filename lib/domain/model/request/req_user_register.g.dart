// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqUserRegister _$ReqUserRegisterFromJson(Map<String, dynamic> json) =>
    ReqUserRegister(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$ReqUserRegisterToJson(ReqUserRegister instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
    };
