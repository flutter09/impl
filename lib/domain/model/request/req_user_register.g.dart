// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_user_register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqUserRegister _$ReqUserRegisterFromJson(Map<String, dynamic> json) =>
    ReqUserRegister(
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
      unique_name: json['unique_name'] as String,
    );

Map<String, dynamic> _$ReqUserRegisterToJson(ReqUserRegister instance) =>
    <String, dynamic>{
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'first_name': instance.first_name,
      'last_name': instance.last_name,
      'unique_name': instance.unique_name,
    };
