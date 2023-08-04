import 'package:json_annotation/json_annotation.dart';

part 'req_user_detail.g.dart';

@JsonSerializable()
class ReqUserDetail {
  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'password')
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
