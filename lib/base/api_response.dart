
// we can't use @JsonSerializable() because it generate .g.dart file every time and we don't want null value for "Map<String, dynamic> json" so that
class ApiResponse<T> {
  final bool? success;

  final int? message;

  final T? data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json,T Function(Map<String, dynamic> json)? fromJsonT,) =>
      ApiResponse<T>(
        success: json['success'] as bool?,
        message: json['message'] as int?,
        data: json['user'] != null ? (json['user'].runtimeType == String ? json['user'] as T : fromJsonT!(json['user'])) : null,
      );

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) => <String, dynamic>{
    'success': this.success,
    'message': this.message,
    'user': T != null ? toJsonT(this.data!) : null,
  };
}