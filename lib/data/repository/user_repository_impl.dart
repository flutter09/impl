import 'dart:io';

import 'package:chat_application/domain/model/request/req_check_otp.dart';
import 'package:chat_application/domain/model/request/req_forgot_password.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/domain/model/request/req_user_detail.dart';
import 'package:chat_application/domain/model/request/req_user_register.dart';
import 'package:dio/dio.dart';

import '../../base/api_response.dart';
import '../../base/result.dart';
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
    var response = await apiService.postForm<ResUserModel>(
        DioApiConstants.userLogin, ResUserModel.fromJson,
        data: request.toFormData());
    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse
                .fromCode(result.message ?? 0)
                .errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<String>> forgotPassword(
      ReqForgotPassword reqForgotPassword) async {
    var response = await apiService.post<String>(
        DioApiConstants.forgotPassword, null,
        data: reqForgotPassword.toJson());

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(
            getApiMessage(result.message) ?? 'password update successfully');
      } else {
        throw Exception(
            ErrorResponse
                .fromCode(result.message ?? 0)
                .errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<ResUserModel>> registerUser(ReqUserRegister reqUserRegister,
      File? image) async {
    var formData = jsonToFormData(
        reqUserRegister.toJson(),
        image != null
            ? // if file is not null than only add to form data other wise we pass init form data object
        await addFileToFormData("image", image,
            FormData()) // key , file , base form data instance
            : FormData());

    var response = await apiService.postForm<ResUserModel>(
        DioApiConstants.userRegister, ResUserModel.fromJson,
        data: formData);

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;

      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse
                .fromCode(result.message ?? 0)
                .errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<String>> sendOtp(ReqSendOtp reqSendOtp) async {
    var response = await apiService.post<String>(
        DioApiConstants.sendOtp, null,
        data: reqSendOtp.toJson());

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(
            getApiMessage(result.message ?? -1) ?? "OTP sent on your mail");
      } else {
        throw Exception(
            ErrorResponse
                .fromCode(result.message ?? 0)
                .errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<ResUserModel>> verifyOtp(ReqCheckOtp reqCheckOtp) async {
    var response = await apiService.post<ResUserModel>(
        DioApiConstants.checkOtp, ResUserModel.fromJson,
        data: reqCheckOtp.toJson());
    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse
                .fromCode(result.message ?? 0)
                .errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<String>> uploadFile(File file,
      Map<String, dynamic> fields) async {
    var data = await fileToFormData("file", file);
    fields.forEach((key, value) {
      data.fields.add(MapEntry(key, value));
    });

    var response = await apiService
        .postForm<String>(DioApiConstants.uploadFile, null, data: data);

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse
                .fromCode(result.message ?? 0)
                .errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<String>> downloadFile(String fileUrl,
      Map<String, dynamic> fields) async {
    var response = await apiService
        .getFile(fileUrl);

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(
            ErrorResponse
                .fromCode(result.message ?? 0)
                .errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<ResUserModel>> getUserDetails() async {
    var response = await apiService.post<ResUserModel>(
        DioApiConstants.getUserDetails, ResUserModel.fromJson);

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;

      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(ErrorResponse
            .fromCode(result.message ?? 0)
            .errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<String>> updateUserDetails(ReqUserDetail reqUserDetail, File? image) async {
    var formData = jsonToFormData(
        reqUserDetail.toJson(),
        image != null
            ? // if file is not null than only add to form data other wise we pass init form data object
        await addFileToFormData("image", image, FormData()) // key , file , base form data instance
            : FormData());

    var response = await apiService.postForm<ResUserModel>(DioApiConstants.updateUser, ResUserModel.fromJson, data: formData);

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(getApiMessage(result.message ?? -1) ?? "User details updated");
      } else {
        throw Exception(ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }

  }
}
