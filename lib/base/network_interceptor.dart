import 'dart:io';

import 'package:chat_application/base/retry_interceptor.dart';
import 'package:dio/dio.dart';

class NetworkInterceptor extends Interceptor{

  final RetryInterceptor retryInterceptor;

  NetworkInterceptor({required this.retryInterceptor});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options = RequestOptions(
        path: options.path,
        receiveTimeout: 15000,
        method: options.method,
        queryParameters: options.queryParameters,
        data: options.data,
        baseUrl: options.baseUrl);
    handler.next(options);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.other && err.error is SocketException;
  }



  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      handler.resolve(
          await retryInterceptor.scheduleRetryRequest(err.requestOptions));
    } else {
      handler.resolve(err.response!);
    }
  }

  Map<String, String> _headers() {
    return {
      'Content-type': 'application/json;charset=UTF-8',
      'Accept': 'application/json',
      'X-localization': Platform.localeName.substring(0, 2),
      'Authorization': 'Bearer '
    };
  }
}