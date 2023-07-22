import 'package:json_annotation/json_annotation.dart';

part 'req_forgot_password.g.dart';

@JsonSerializable()
class ReqForgotPassword {
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;

  ReqForgotPassword({
    required this.email, required this.password,
  });

  factory ReqForgotPassword.fromJson(Map<String, dynamic> json) =>
      _$ReqForgotPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$ReqForgotPasswordToJson(this);
}
