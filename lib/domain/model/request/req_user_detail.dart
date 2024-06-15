


class ReqUserDetail {
  final String name;

  final String email;

  final String phone;

  final String password;

  ReqUserDetail({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory ReqUserDetail.fromJson(Map<String, dynamic> json) => _$ReqUserDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ReqUserDetailToJson(this);
}
ReqUserDetail _$ReqUserDetailFromJson(Map<String, dynamic> json) =>
    ReqUserDetail(
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$ReqUserDetailToJson(ReqUserDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'password': instance.password,
    };