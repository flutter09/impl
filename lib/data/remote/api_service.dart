import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../../base/result.dart';
import '../../base/api_response.dart';

abstract class ApiService{
  Future<Result<ApiResponse<T>>?> get<T>(String url , {Map<String,dynamic> queryParameters , required T Function(Map<String, dynamic> json) fromJsonT});
  Future<Result<ApiResponse<T>>?> post<T>(String url , T Function(Map<String, dynamic> json) fromJsonT, {Map data});
  Future<Result<ApiResponse<T>>?> delete<T>(String url ,T Function(Map<String, dynamic> json) fromJsonT);
  Future<Result<ApiResponse<T>>?> patch<T>(String url , Map data , T Function(Map<String, dynamic> json) fromJsonT);
  Future<Result<ApiResponse<T>>?> postFile<T>(String url , T Function(Map<String, dynamic> json)? fromJsonT, {dynamic data});
}