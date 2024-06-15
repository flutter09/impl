import 'package:dio/dio.dart';


class ReqUserRegister {

  final String email;

  final String phone;

  final String password;

  final String first_name;
  final String last_name;
  final String unique_name;


  ReqUserRegister( {
    required this.email,
    required this.phone,
    required this.password,
    required this.first_name,  required this.last_name, required this.unique_name,
  });

  factory ReqUserRegister.fromJson(Map<String, dynamic> json) =>
      _$ReqUserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$ReqUserRegisterToJson(this);

  FormData toFormData() => FormData.fromMap(toJson());
}
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