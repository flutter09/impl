import 'dart:io';

import 'package:chat_application/base/retry_interceptor.dart';
import 'package:dio/dio.dart';

import '../data/local/preference_constant.dart';
import '../data/local/preference_utils.dart';

class NetworkInterceptor extends Interceptor {
  final RetryInterceptor retryInterceptor;

  NetworkInterceptor({required this.retryInterceptor});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options = RequestOptions(
        path: options.path,
        receiveTimeout: const Duration(milliseconds: 5000),
        method: options.method,
        queryParameters: options.queryParameters,
        data: options.data,
        headers: _headers(),
        baseUrl: options.baseUrl);
    handler.next(options);
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.connectionTimeout &&
        err.error is SocketException;
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      handler.resolve(
          await retryInterceptor.scheduleRetryRequest(err.requestOptions));
    } else {
      try {
        handler.resolve(err.response!);
      } catch (e) {
        final customError = DioError(
          error: 'Server Error',
          type: err.type,
          requestOptions: err.requestOptions,
          response: err.response,
        );
        handler.next(customError);
      }
    }
  }

  Map<String, String> _headers() {
    return {
      'token': getString(PreferenceConstant.token),
      'user_id': getString(PreferenceConstant.userId)
    };
  }
}
