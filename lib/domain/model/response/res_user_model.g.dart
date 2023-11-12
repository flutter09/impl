// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'res_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResUserModel _$ResUserModelFromJson(Map<String, dynamic> json) => ResUserModel(
      id: json['_id'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      password: json['password'] as String?,
      image: json['image'] as String?,
      uniqueName: json['unique_name'] as String?,
      dateOfBirth: json['Date_of_Birth'] as String?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      country: json['country'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      jwt: json['jwt'] as String?,
      tokens:
          (json['tokens'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      referralCode: json['referral_code'] as String?,
      referredBy: json['referred_by'] as String?,
      referredCredit: json['referred_credit'] as int?,
      userSaveId: (json['userSave_id'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : UserSaveData.fromJson(e as Map<String, dynamic>))
          .toList(),
      isEmailVerify: json['is_email_verify'] as bool?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      uniqueId: json['unique_id'] as int?,
      v: json['__v'] as int?,
    )..defaultName = json['default_name'] as String?;

Map<String, dynamic> _$ResUserModelToJson(ResUserModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
      'image': instance.image,
      'unique_name': instance.uniqueName,
      'default_name': instance.defaultName,
      'Date_of_Birth': instance.dateOfBirth,
      'address': instance.address,
      'city': instance.city,
      'country': instance.country,
      'roles': instance.roles,
      'jwt': instance.jwt,
      'tokens': instance.tokens,
      'referral_code': instance.referralCode,
      'referred_by': instance.referredBy,
      'referred_credit': instance.referredCredit,
      'userSave_id': instance.userSaveId,
      'is_email_verify': instance.isEmailVerify,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'unique_id': instance.uniqueId,
      '__v': instance.v,
    };

UserSaveData _$UserSaveDataFromJson(Map<String, dynamic> json) => UserSaveData(
      userId: json['user_id'] as String?,
      userName: json['userName'] as String?,
      roles: (json['roles'] as List<dynamic>?)?.map((e) => e as int).toList(),
      name: json['name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      userSaveId: json['_id'] as String?,
      image: json['image'] as String?,
    );

Map<String, dynamic> _$UserSaveDataToJson(UserSaveData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'userName': instance.userName,
      'roles': instance.roles,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      '_id': instance.userSaveId,
      'image': instance.image,
    };
