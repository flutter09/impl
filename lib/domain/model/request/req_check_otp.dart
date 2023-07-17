import 'package:json_annotation/json_annotation.dart';

part 'req_check_otp.g.dart';

@JsonSerializable()
class ReqCheckOtp {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'email_otp')
  final String emailOtp;

  ReqCheckOtp({
    required this.email,
    required this.emailOtp,
  });

  factory ReqCheckOtp.fromJson(Map<String, dynamic> json) =>
      _$ReqCheckOtpFromJson(json);

  Map<String, dynamic> toJson() => _$ReqCheckOtpToJson(this);
}
