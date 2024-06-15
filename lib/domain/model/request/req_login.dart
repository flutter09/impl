import 'package:dio/dio.dart';


class ReqLogin {
  final String email;

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
ReqLogin _$ReqLoginFromJson(Map<String, dynamic> json) => ReqLogin(
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$ReqLoginToJson(ReqLogin instance) => <String, dynamic>{
  'email': instance.email,
  'password': instance.password,
};
