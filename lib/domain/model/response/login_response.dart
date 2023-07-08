import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse{

  @JsonKey(name: "token")
  String? token;

  LoginResponse(this.token);

  //from json
  factory LoginResponse.fromJson(Map<String,dynamic> json) => _$LoginResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}