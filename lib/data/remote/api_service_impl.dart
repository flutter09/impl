import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import '../../base/api_response.dart';
import '../../base/network_interceptor.dart';
import '../../base/result.dart';
import '../../base/retry_interceptor.dart';
import '../../domain/model/response/error_response.dart';
import 'api_constant.dart';
import 'api_service.dart';

class ApiServiceImpl implements ApiService {
  Dio? dio;
  Connectivity? connectivity;
  BaseOptions? options;

  ApiServiceImpl._() {
    dio = Dio();
    connectivity = Connectivity();
    dio?.interceptors.add(NetworkInterceptor(
      retryInterceptor: RetryInterceptor(dio: dio, connectivity: connectivity),
    ));
    if (kDebugMode) {
      dio?.interceptors.add(LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    }
    dio?.options =
        BaseOptions(connectTimeout: 5 * 60 * 1000, receiveTimeout: 5 * 60 * 1000);
  }

  static final ApiServiceImpl apiServiceImpl = ApiServiceImpl._();

  factory ApiServiceImpl() {
    return apiServiceImpl;
  }

  @override
  Future<Result<ApiResponse<T>>?> delete<T>(
      String url, T Function(Map<String, dynamic> json) fromJsonT) async {
    var response = await dio?.delete(DioApiConstants.baseUrl);
    if (response?.statusCode == 200) {
      try {
        print("Response : ${response?.data}");
        return Success(ApiResponse.fromJson(response?.data, fromJsonT));
      } catch (e) {
        print("Error : ${e.toString()}");
        return Error(ErrorResponse(errorMessage: e.toString()));
      }
    } else {
      return Error(ErrorResponse(
          errorMessage: response?.statusMessage ?? "null response found"));
    }
  }

  @override
  Future<Result<ApiResponse<T>>?> get<T>(String url,
      {Map<String, dynamic>? queryParameters,
      required T Function(Map<String, dynamic> json) fromJsonT}) async {
    var response = await dio?.get(DioApiConstants.baseUrl + url,
        queryParameters: queryParameters);
    if (response?.statusCode == 200) {
      try {
        print("Response : ${response?.data}");
        return Success(ApiResponse.fromJson(response?.data, fromJsonT));
      } catch (e) {
        print("Error : ${e.toString()}");
        return Error(ErrorResponse(errorMessage: e.toString()));
      }
    } else {
      return Error(ErrorResponse(
          errorMessage: response?.statusMessage ?? "null response found"));
    }
  }

  @override
  Future<Result<ApiResponse<T>>?> patch<T>(String url, Map data,
      T Function(Map<String, dynamic> json) fromJsonT) async {
    var response = await dio?.patch(DioApiConstants.baseUrl + url, data: data);
    if (response?.statusCode == 200) {
      try {
        print("Response : ${response?.data}");
        return Success(ApiResponse.fromJson(response?.data, fromJsonT));
      } catch (e) {
        print("Error : ${e.toString()}");
        return Error(ErrorResponse(errorMessage: e.toString()));
      }
    } else {
      return Error(ErrorResponse(
          errorMessage: response?.statusMessage ?? "null response found"));
    }
  }

  @override
  Future<Result<ApiResponse<T>>?> post<T>(
      String url, dynamic Function(Map<String, dynamic> json)? fromJsonT,
      {Map<dynamic, dynamic>? data}) async {
    var response = await dio?.post(DioApiConstants.baseUrl + url, data: data);
    if (response?.statusCode == 200) {
      try {
        print("Response : ${response?.data}");
        return Success(ApiResponse.fromJson(response?.data, fromJsonT));
      } catch (e) {
        print("Error : API SERVICE IMPL / ${e.toString()}");
        return Error(ErrorResponse(errorMessage: e.toString()));
      }
    } else {
      print("api service ${response?.statusMessage}");
      return Error(ErrorResponse(
          errorMessage: response?.statusMessage ?? "null response found"));
    }
  }

  @override
  Future<Result<ApiResponse<T>>?> postFile<T>(
      String url, T Function(Map<String, dynamic> json)? fromJsonT,
      {data}) async {
    var response = await dio?.post(DioApiConstants.baseUrl + url,
        data: data,
        options: Options(
            contentType: 'multipart/form-data',
            sendTimeout: 5 * 60 * 1000,
            // 60 seconds
            receiveTimeout: 5 * 60 * 1000));
    if (response?.statusCode == 200) {
      try {
        print("Response : ${response?.data}");
        return Success(ApiResponse.fromJson(response?.data, fromJsonT));
      } catch (e) {
        print("Error : ${e.toString()}");
        return Error(ErrorResponse(errorMessage: e.toString()));
      }
    } else {
      return Error(ErrorResponse(
          errorMessage: response?.statusMessage ?? "null response found"));
    }
  }

  @override
  Future<Result<ApiResponse<String>>?> getFile(
    String fileUrl,
  ) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName = fileUrl.split('/').last;
    final savePath = '${appDir.path}/$fileName';

    try {
      await dio!.download(
        fileUrl,
        savePath,
      );
      return Success(ApiResponse(
          success: true,
          message: 0,
          data: 'Downloading at $savePath',
          description: 'Downloading at $savePath'));
    } catch (e) {
      return Error(ErrorResponse(errorMessage: e.toString()));
    }
  }

/*@override
  Future<Result<ApiResponse<T>>?> postList<T>(
      String url, T Function(Map<String, dynamic> json)? fromJsonT,
      {Map<dynamic, dynamic>? data}) async {
    var response = await dio?.post(DioApiConstants.baseUrl + url, data: data);
    if (response?.statusCode == 200) {
      try {
        print("Response : ${response?.data}");
        return Success(ApiResponse.fromJson(response?.data, fromJsonT));
      } catch (e) {
        print("Error : ${e.toString()}");
        return Error(ErrorResponse(errorMessage: e.toString()));
      }
    } else {
      return Error(ErrorResponse(
          errorMessage: response?.statusMessage ?? "null response found"));
    }
  }*/
}
