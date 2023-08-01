// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResUserModel _$ResUserModelFromJson(Map<String, dynamic> json) => ResUserModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
      accessToken: json['jwt'] as String?,
      token: json['token'] as String?,
      referralCode: json['referral_code'] as String?,
      referredBy: json['referred_by'] as String?,
      referredCredit: json['referred_credit'] as int?,
      userSaveId: (json['userSave_id'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      uniqueId: json['unique_id'] as int?,
      version: json['__v'] as int?,
      tokens:
          (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$ResUserModelToJson(ResUserModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'image': instance.image,
      'jwt': instance.accessToken,
      'token': instance.token,
      'referral_code': instance.referralCode,
      'referred_by': instance.referredBy,
      'referred_credit': instance.referredCredit,
      'userSave_id': instance.userSaveId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'unique_id': instance.uniqueId,
      '__v': instance.version,
      'tokens': instance.tokens,
    };
