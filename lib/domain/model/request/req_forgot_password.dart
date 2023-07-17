import 'package:json_annotation/json_annotation.dart';

part 'req_forgot_password.g.dart';

@JsonSerializable()
class ReqForgotPassword {
  @JsonKey(name: 'email')
  final String email;

  ReqForgotPassword({
    required this.email,
  });

  factory ReqForgotPassword.fromJson(Map<String, dynamic> json) =>
      _$ReqForgotPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$ReqForgotPasswordToJson(this);
}
