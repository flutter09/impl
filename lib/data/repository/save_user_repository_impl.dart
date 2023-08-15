import 'package:chat_application/base/result.dart';

import 'package:chat_application/domain/model/request/req_add_save_user.dart';

import 'package:chat_application/domain/model/request/req_send_otp.dart';

import 'package:chat_application/domain/model/response/save_user_model.dart';

import '../../base/api_response.dart';
import '../../domain/model/response/error_response.dart';
import '../../domain/repository/save_user_repository.dart';
import '../remote/api_constant.dart';
import '../remote/api_service.dart';

class SaveUserRepositoryImpl extends SaveUserRepository {

  final ApiService apiService;

  SaveUserRepositoryImpl({required this.apiService});

  @override
  Future<Result<String>> addSaveUser(ReqAddSaveUser reqAddSaveUser) async {
    var response = await apiService.post<String>(
        DioApiConstants.addUserSaveList, null,
        data: reqAddSaveUser.toJson()
    );

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.description ?? 'user add successfully');
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<String>> editSaveUser(ReqAddSaveUser reqAddSaveUser) async {
    var response = await apiService.post<String>(
        DioApiConstants.editUserSaveList, null,
        data: reqAddSaveUser.toJson()
    );

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.description ?? 'user update successfully');
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<SaveUserModel>> getSaveUser(ReqSendOtp email) async {
    var response = await apiService.post<SaveUserModel>(
        DioApiConstants.getOtherUserDetail, SaveUserModel.fromJson,
        data: email.toJson()
    );

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

}