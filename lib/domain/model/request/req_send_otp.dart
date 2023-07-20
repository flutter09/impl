import 'package:json_annotation/json_annotation.dart';

part 'req_send_otp.g.dart';

@JsonSerializable()
class ReqSendOtp{
  @JsonKey(name : 'email')
  final String email;

  ReqSendOtp({
    required this.email,
  });

  factory ReqSendOtp.fromJson(Map<String, dynamic> json) =>
      _$ReqSendOtpFromJson(json);

  Map<String, dynamic> toJson() => _$ReqSendOtpToJson(this);

}