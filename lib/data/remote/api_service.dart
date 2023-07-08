import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

abstract class ApiService{
  Future<Response?> get(String url , {Map<String,dynamic> queryParameters});
  Future<Response?> post(String url , {Map data});
  Future<Response?> delete(String url);
  Future<Response?> patch(String url , Map data);
}