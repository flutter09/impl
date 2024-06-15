import '../../../utils/utils.dart';


class ErrorResponse {

  String errorMessage;

  ErrorResponse({required this.errorMessage});

  factory ErrorResponse.fromCode(int code) => ErrorResponse(errorMessage: getApiMessage(code) ?? "Not found specific error");
  //from json
  factory ErrorResponse.fromJson(Map<String,dynamic> json) => _$ErrorResponseFromJson(json);

  //to json
  Map<String,dynamic> toJson() => _$ErrorResponseToJson(this);

}

ErrorResponse _$ErrorResponseFromJson(Map<String, dynamic> json) =>
    ErrorResponse(
      errorMessage: json['error'] as String,
    );

Map<String, dynamic> _$ErrorResponseToJson(ErrorResponse instance) =>
    <String, dynamic>{
      'error': instance.errorMessage,
    };