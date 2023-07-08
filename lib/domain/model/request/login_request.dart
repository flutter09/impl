
import 'package:json_annotation/json_annotation.dart';
part 'login_request.g.dart';


@JsonSerializable()
class LoginRequest{
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "password")
  String? password;


  LoginRequest(this.email, this.password);

// from json
  factory LoginRequest.fromJson(Map<String, dynamic> json) => _$LoginRequestFromJson(json);

// to json
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}