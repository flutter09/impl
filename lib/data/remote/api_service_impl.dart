import 'package:flutter/foundation.dart';
import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../../base/network_interceptor.dart';
import '../../base/retry_interceptor.dart';
import 'api_constant.dart';
import 'api_service.dart';

class ApiServiceImpl implements ApiService{

  Dio? dio;
  Connectivity? connectivity;

  ApiServiceImpl._(){
    dio = Dio();
    connectivity = Connectivity();
    dio?.interceptors.add(NetworkInterceptor(
      retryInterceptor: RetryInterceptor(dio: dio, connectivity: connectivity),
    ));
    if (kDebugMode) {
      dio?.interceptors.add(
          LogInterceptor(requestBody: true, responseBody: true, error: true,));
    }
  }

  static final ApiServiceImpl apiServiceImpl = ApiServiceImpl._();

  factory ApiServiceImpl() {
    return apiServiceImpl;
  }

  @override
  Future<Response?> delete(String url) async {
    var response = await dio?.delete(DioApiConstants.baseUrl);
    return response;
  }

  @override
  Future<Response?> get(String url, {Map<String, dynamic>? queryParameters}) async {
    var response = await dio?.get(DioApiConstants.baseUrl + url,queryParameters: queryParameters);
    return response;
  }

  @override
  Future<Response?> patch(String url, Map data) async {
    var response = await dio?.patch(DioApiConstants.baseUrl+url , data: data);
    return response;
  }

  @override
  Future<Response?> post(String url, {Map<dynamic, dynamic>? data}) async {
    var response = await dio?.post(DioApiConstants.baseUrl+url , data: data);
    return response;
  }
  
}