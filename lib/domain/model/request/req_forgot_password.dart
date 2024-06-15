


class ReqForgotPassword {
  final String email;
  final String password;

  ReqForgotPassword({
    required this.email, required this.password,
  });

  factory ReqForgotPassword.fromJson(Map<String, dynamic> json) =>
      _$ReqForgotPasswordFromJson(json);

  Map<String, dynamic> toJson() => _$ReqForgotPasswordToJson(this);
}
ReqForgotPassword _$ReqForgotPasswordFromJson(Map<String, dynamic> json) =>
    ReqForgotPassword(
      email: json['email'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$ReqForgotPasswordToJson(ReqForgotPassword instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
    };