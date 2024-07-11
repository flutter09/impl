import 'package:chat_application/base/result.dart';
import 'package:chat_application/domain/model/request/req_add_save_user.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/domain/model/response/search_user_model.dart';

import '../../base/api_response.dart';
import '../../domain/repository/save_user_repository.dart';
import '../local/preference_constant.dart';
import '../local/preference_utils.dart';
import '../remote/api_constant.dart';
import '../remote/api_service.dart';

class SaveUserRepositoryImpl extends SaveUserRepository {

  final ApiService apiService;

  SaveUserRepositoryImpl({required this.apiService});

  @override
  Future<Result<String>> addSaveUser(ReqAddSaveUser reqAddSaveUser) async {
    var response = await apiService.post<String>(
        DioApiConstants.addUserSaveList, fromJsonT: null,
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
        DioApiConstants.editUserSaveList, fromJsonT: null,
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
  Future<Result<SearchUserData>> getSaveUser(ReqSendOtp email) async {
    var response = await apiService.post<SearchUserData>(
        DioApiConstants.getOtherUserDetail, fromJsonT: SearchUserData.fromJson,
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

  @override
  Future<Result<List<SaveUser>>> getSaveUserList() async {
    var response = await apiService.post<List<dynamic>>(
      /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.getSaveUserList, fromJsonT: SaveUser.fromJson , data: <String,dynamic>{
          "user_id_of_main_user": getString(PreferenceConstant.userId),
      "user_id": getString(PreferenceConstant.userId)
        }
    );

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success((result.data as List<dynamic>).map((e) => e as SaveUser).toList());
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

}