import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

part 'req_login.g.dart';

@JsonSerializable()
class ReqLogin {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'password')
  final String password;

  ReqLogin({
    required this.email,
    required this.password,
  });

  factory ReqLogin.fromJson(Map<String, dynamic> json) =>
      _$ReqLoginFromJson(json);

  Map<String, dynamic> toJson() => _$ReqLoginToJson(this);

  FormData toFormData() => FormData.fromMap(toJson());
}
