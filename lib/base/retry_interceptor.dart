import 'dart:async';

import 'package:dio/dio.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class RetryInterceptor{
  Dio? dio;
  Connectivity? connectivity;

  RetryInterceptor({required this.dio , required this.connectivity});

  Future<Response> scheduleRetryRequest(RequestOptions requestOptions) async {
    StreamSubscription<List<ConnectivityResult>>? streamSubscription;
    final response = Completer<Response>();
    streamSubscription =
        connectivity?.onConnectivityChanged.listen((connectivityResult) {
          if (connectivityResult == ConnectivityResult.wifi ||
              connectivityResult == ConnectivityResult.mobile) {
            streamSubscription?.cancel();
            response.complete(dio?.request(
              requestOptions.path,
              data: requestOptions.data,
              options: Options(
                  headers: requestOptions.headers, method: requestOptions.method),
            ));
          }
        });
    return await response.future;
  }
}