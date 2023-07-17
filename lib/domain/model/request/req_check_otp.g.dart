// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'req_check_otp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReqCheckOtp _$ReqCheckOtpFromJson(Map<String, dynamic> json) => ReqCheckOtp(
      email: json['email'] as String,
      emailOtp: json['email_otp'] as String,
    );

Map<String, dynamic> _$ReqCheckOtpToJson(ReqCheckOtp instance) =>
    <String, dynamic>{
      'email': instance.email,
      'email_otp': instance.emailOtp,
    };
