import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'req_user_register.g.dart';

@JsonSerializable()
class ReqUserRegister {

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'first_name')
  final String first_name;
  @JsonKey(name: 'last_name')
  final String last_name;
  @JsonKey(name: 'unique_name')
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
