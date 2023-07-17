import 'package:json_annotation/json_annotation.dart';

import '../../../utils/utils.dart';

part 'error_response.g.dart';

@JsonSerializable()
class ErrorResponse {

  @JsonKey(name: "error")
  String errorMessage;

  ErrorResponse({required this.errorMessage});

  factory ErrorResponse.fromCode(int code) => ErrorResponse(errorMessage: getApiMessage(code) ?? "Not found specific error");
  //from json
  factory ErrorResponse.fromJson(Map<String,dynamic> json) => _$ErrorResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson() => _$ErrorResponseToJson(this);

}