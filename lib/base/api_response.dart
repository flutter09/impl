
// we can't use @JsonSerializable() because it generate .g.dart file every time and we don't want null value for "Map<String, dynamic> json" so that
class ApiResponse<T> {
  final bool? success;

  final int? message;

  final T? data;

  final String? description;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
    required this.description,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json,dynamic Function(Map<String, dynamic> json)? fromJsonT,){

    T data;
    dynamic jsonData = json['data'];
    if (jsonData is String) {
      data = jsonData as T;
    } else if (jsonData is List) {
      data = jsonData.map((item) => fromJsonT!(item)).toList() as T;
    } else {
      data = fromJsonT!(jsonData) as T;
    }

    return ApiResponse<T>(
      success: json['success'] as bool?,
      message: json['message'] as int?,
      data: json['data'] != null ? data : null,
      description: json['description'] as String?,
    );
  }

  // factory ApiResponse.fromList(Map<String, dynamic> json, dynamic Function(Map<String, dynamic> json)? fromJsonT,) =>
  //     ApiResponse<T>(
  //       success: json['success'] as bool?,
  //       message: json['message'] as int?,
  //       data: (json['data'] != null && fromJsonT != null) ? (json['data'].runtimeType == String ? json['data'] as T : fromJsonT(json['data'])) : null,
  //       description: json['description'] as String?,
  //     );

  Map<String, dynamic> toJson(Map<String, dynamic> Function(T value) toJsonT) => <String, dynamic>{
    'success': this.success,
    'message': this.message,
    'data': T != null ? toJsonT(this.data!) : null,
    'description' : this.description,
  };
}