import 'dart:io';

import 'package:chat_application/domain/model/request/req_check_otp.dart';

import 'package:chat_application/domain/model/request/req_forgot_password.dart';

import 'package:chat_application/domain/model/request/req_send_otp.dart';

import 'package:chat_application/domain/model/request/req_user_register.dart';

import '../../base/result.dart';
import '../../base/api_response.dart';
import '../../domain/model/request/req_login.dart';
import '../../domain/model/response/error_response.dart';
import '../../domain/model/response/res_user_model.dart';
import '../../domain/repository/user_repository.dart';
import '../../utils/utils.dart';
import '../remote/api_constant.dart';
import '../remote/api_service.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;

  UserRepositoryImpl({required this.apiService});

  @override
  Future<Result<ResUserModel>> login(ReqLogin request) async {
    var response = await apiService.post<ResUserModel>(
        DioApiConstants.userLogin, ResUserModel.fromJson,
        data: request.toJson());
    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      print(result.data);
      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<ResUserModel>> forgotPassword(ReqForgotPassword reqForgotPassword) async {
    var response = await apiService.post<ResUserModel>(
        DioApiConstants.forgotPassword,
        ResUserModel.fromJson,
        data: reqForgotPassword.toJson()
    );

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      print(result.data);
      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<ResUserModel>> registerUser(ReqUserRegister reqUserRegister) async {
    var response = await apiService.post<ResUserModel>(
        DioApiConstants.userRegister, ResUserModel.fromJson,
        data: reqUserRegister.toJson());
    if (response is Success) {

      var result = (response as Success).data as ApiResponse;

      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<ResUserModel>> sendOtp(ReqSendOtp reqSendOtp) {
    // TODO: implement sendOtp
    throw UnimplementedError();
  }

  @override
  Future<Result<ResUserModel>> verifyOtp(ReqCheckOtp reqCheckOtp) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }

  @override
  Future<Result<String>> uploadFile(File file , Map<String , dynamic> fields) async {

    var data = await fileToFormData("file",file);
    fields.forEach((key, value) {
      data.fields.add(MapEntry(key, value));
    });

    var response = await apiService.postFile<String>(
        DioApiConstants.uploadFile,
        null,
        data: data
    );

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }
}
