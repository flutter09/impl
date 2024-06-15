


class ReqSendOtp{
  final String email;

  ReqSendOtp({
    required this.email,
  });

  factory ReqSendOtp.fromJson(Map<String, dynamic> json) =>
      _$ReqSendOtpFromJson(json);

  Map<String, dynamic> toJson() => _$ReqSendOtpToJson(this);

}

ReqSendOtp _$ReqSendOtpFromJson(Map<String, dynamic> json) => ReqSendOtp(
  email: json['email'] as String,
);

Map<String, dynamic> _$ReqSendOtpToJson(ReqSendOtp instance) =>
    <String, dynamic>{
      'email': instance.email,
    };
