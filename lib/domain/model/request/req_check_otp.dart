


class ReqCheckOtp {
  final String email;

  final String emailOtp;

  ReqCheckOtp({
    required this.email,
    required this.emailOtp,
  });

  factory ReqCheckOtp.fromJson(Map<String, dynamic> json) =>
      _$ReqCheckOtpFromJson(json);

  Map<String, dynamic> toJson() => _$ReqCheckOtpToJson(this);
}
ReqCheckOtp _$ReqCheckOtpFromJson(Map<String, dynamic> json) => ReqCheckOtp(
  email: json['email'] as String,
  emailOtp: json['email_otp'] as String,
);

Map<String, dynamic> _$ReqCheckOtpToJson(ReqCheckOtp instance) =>
    <String, dynamic>{
      'email': instance.email,
      'email_otp': instance.emailOtp,
    };
