import '../../base/api_response.dart';
import '../../base/result.dart';

abstract class ApiService {
  Future<Result<ApiResponse<T>>?> get<T>(String url,
      {Map<String, dynamic> queryParameters,
      required T Function(Map<String, dynamic> json) fromJsonT});

  Future<Result<ApiResponse<T>>?> post<T>(
      String url, dynamic Function(Map<String, dynamic> json)? fromJsonT,
      {Map data});

  Future<Result<ApiResponse<T>>?> delete<T>(
      String url, T Function(Map<String, dynamic> json) fromJsonT);

  Future<Result<ApiResponse<T>>?> patch<T>(
      String url, Map data, T Function(Map<String, dynamic> json) fromJsonT);

  Future<Result<ApiResponse<T>>?> postForm<T>(
      String url, T Function(Map<String, dynamic> json)? fromJsonT,
      {dynamic data});

  Future<Result<ApiResponse<String>>?> getFile(String url);

// Future<Result<ApiResponse<T>>?> postList<T>(String url , T Function(Map<String, dynamic> json)? fromJsonT, {Map data});
}
