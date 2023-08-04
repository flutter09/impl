// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResUserModel _$ResUserModelFromJson(Map<String, dynamic> json) => ResUserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
      uniqueName: json['unique_name'] as String?,
      dateOfBirth: json['Date_of_Birth'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      technology: json['technology'] as String?,
      jwt: json['jwt'] as String?,
      tokens:
          (json['tokens'] as List<dynamic>?)?.map((e) => e as String).toList(),
      referralCode: json['referral_code'] as String?,
      referredBy: json['referred_by'] as String?,
      referredCredit: json['referred_credit'] as int?,
      userSaveId: (json['userSave_id'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      isEmailVerify: json['is_email_verify'] as bool?,
      id: json['_id'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      uniqueId: json['unique_id'] as int?,
      version: json['__v'] as int?,
    );

Map<String, dynamic> _$ResUserModelToJson(ResUserModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'image': instance.image,
      'unique_name': instance.uniqueName,
      'Date_of_Birth': instance.dateOfBirth,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'technology': instance.technology,
      'jwt': instance.jwt,
      'tokens': instance.tokens,
      'referral_code': instance.referralCode,
      'referred_by': instance.referredBy,
      'referred_credit': instance.referredCredit,
      'userSave_id': instance.userSaveId,
      'is_email_verify': instance.isEmailVerify,
      '_id': instance.id,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'unique_id': instance.uniqueId,
      '__v': instance.version,
    };
