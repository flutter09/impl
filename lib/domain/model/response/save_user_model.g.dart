// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SaveUserModel _$SaveUserModelFromJson(Map<String, dynamic> json) =>
    SaveUserModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      image: json['image'] as String,
    );

Map<String, dynamic> _$SaveUserModelToJson(SaveUserModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'image': instance.image,
    };
