import 'package:json_annotation/json_annotation.dart';

part 'req_user_register.g.dart';

@JsonSerializable()
class ReqUserRegister {


  @JsonKey(name: 'user_id')
  final String? user_id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'password')
  final String password;

  ReqUserRegister({
    this.user_id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory ReqUserRegister.fromJson(Map<String, dynamic> json) =>
      _$ReqUserRegisterFromJson(json);

  Map<String, dynamic> toJson() => _$ReqUserRegisterToJson(this);
}
