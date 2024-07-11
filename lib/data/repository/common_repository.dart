import 'dart:io';

import 'package:chat_application/base/result.dart';
import 'package:chat_application/data/remote/api_constant.dart';
import 'package:chat_application/domain/model/request/req_add_group_member.dart';
import 'package:chat_application/domain/model/request/req_add_save_user.dart';
import 'package:chat_application/domain/model/request/req_check_otp.dart';
import 'package:chat_application/domain/model/request/req_forgot_password.dart';
import 'package:chat_application/domain/model/request/req_group_detail.dart';
import 'package:chat_application/domain/model/request/req_project_detail.dart';
import 'package:chat_application/domain/model/request/req_register_group.dart';
import 'package:chat_application/domain/model/request/req_register_project.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/domain/model/request/req_user_detail.dart';
import 'package:chat_application/domain/model/request/req_user_register.dart';
import 'package:chat_application/domain/model/response/res_group.dart';
import 'package:chat_application/domain/model/response/res_project.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/domain/model/response/search_user_model.dart';
import 'package:dio/dio.dart';

import '../../base/api_response.dart';
import '../../domain/model/request/req_add_project_member.dart';
import '../../domain/model/request/req_login.dart';
import '../../domain/model/response/error_response.dart';
import '../../domain/model/response/res_user_model.dart';
import '../../utils/utils.dart';
import '../local/preference_constant.dart';
import '../local/preference_utils.dart';
import '../remote/api_service.dart';

class CommonRepository {
  final ApiService apiService;

  CommonRepository({required this.apiService});

  
  Future<Result<Project>> addProjectMember(
      ReqAddProjectMember reqAddProjectMember) async {
    var response = await apiService.post<Project>(
        DioApiConstants.projectAddMembers,
        fromJsonT: Project.fromJson,
        data: reqAddProjectMember.toJson());

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

  
  Future<Result<Project>> getProjectDetail(
      ReqProjectDetail reqProjectDetail) async {
    var response = await apiService.post(DioApiConstants.projectDetails,
        data: reqProjectDetail.toJson());

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(Project.fromJson((result.data as List<dynamic>).first));
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<String>> registerProject(
      ReqRegisterProject registerProject) async {
    var response = await apiService.post<String>(
        DioApiConstants.projectRegister,
        fromJsonT: null,
        data: registerProject.toJson());

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.description ?? 'Add Successfully');
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<Project>> updateProject(Project resProject) async {
    var response = await apiService.post<Project>(DioApiConstants.projectUpdate,
        fromJsonT: Project.fromJson, data: resProject.toJson());

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

  Future<Result<OurProjectList>> getMyProject() async {
    var response = await apiService.post<OurProjectList>(

        /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.ourProjectList,
        fromJsonT: OurProjectList.fromJson);

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

  Future<Result<FavouriteProjectList>> getMyFavouriteProject() async {
    var response = await apiService.post<FavouriteProjectList>(

        /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.ourFavouriteProject,
        fromJsonT: FavouriteProjectList.fromJson);

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

  Future<Result<ProjectList>> getOtherProject() async {
    var response = await apiService.post<ProjectList>(

        /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.projectList,
        fromJsonT: ProjectList.fromJson);

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

  Future<Result<FavouriteProjectList>> getOtherFavouriteProject() async {
    var response = await apiService.post<FavouriteProjectList>(

        /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.favouriteProject,
        fromJsonT: FavouriteProjectList.fromJson);

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
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<String>> forgotPassword(
      ReqForgotPassword reqForgotPassword) async {
    var response = await apiService.post<String>(DioApiConstants.forgotPassword,
        fromJsonT: null, data: reqForgotPassword.toJson());

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(
            getApiMessage(result.message) ?? 'password update successfully');
      } else {
        throw Exception(
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<ResUserModel>> registerUser(
      ReqUserRegister reqUserRegister, File? image) async {
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
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<String>> sendOtp(ReqSendOtp reqSendOtp) async {
    var response = await apiService.post<String>(DioApiConstants.sendOtp,
        fromJsonT: null, data: reqSendOtp.toJson());

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(
            getApiMessage(result.message ?? -1) ?? "OTP sent on your mail");
      } else {
        throw Exception(
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<ResUserModel>> verifyOtp(ReqCheckOtp reqCheckOtp) async {
    var response = await apiService.post<ResUserModel>(DioApiConstants.checkOtp,
        fromJsonT: ResUserModel.fromJson, data: reqCheckOtp.toJson());
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

  
  Future<Result<String>> uploadFile(
      File file, Map<String, dynamic> fields) async {
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
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<String>> downloadFile(
      String fileUrl, Map<String, dynamic> fields) async {
    var response = await apiService.getFile(fileUrl);

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

  
  Future<Result<ResUserModel>> getUserDetails() async {
    var response = await apiService.post<ResUserModel>(
        DioApiConstants.getUserDetails,
        fromJsonT: ResUserModel.fromJson);

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

  
  Future<Result<String>> updateUserDetails(
      ReqUserDetail reqUserDetail, File? image) async {
    var formData = jsonToFormData(
        reqUserDetail.toJson(),
        image != null
            ? // if file is not null than only add to form data other wise we pass init form data object
            await addFileToFormData("image", image,
                FormData()) // key , file , base form data instance
            : FormData());

    var response = await apiService.postForm<ResUserModel>(
        DioApiConstants.updateUser, ResUserModel.fromJson,
        data: formData);

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(
            getApiMessage(result.message ?? -1) ?? "User details updated");
      } else {
        throw Exception(
            ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<String>> addSaveUser(ReqAddSaveUser reqAddSaveUser) async {
    var response = await apiService.post<String>(
        DioApiConstants.addUserSaveList,
        fromJsonT: null,
        data: reqAddSaveUser.toJson());

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

  
  Future<Result<String>> editSaveUser(ReqAddSaveUser reqAddSaveUser) async {
    var response = await apiService.post<String>(
        DioApiConstants.editUserSaveList,
        fromJsonT: null,
        data: reqAddSaveUser.toJson());

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

  
  Future<Result<SearchUserData>> getSaveUser(ReqSendOtp email) async {
    var response = await apiService.post<SearchUserData>(
        DioApiConstants.getOtherUserDetail,
        fromJsonT: SearchUserData.fromJson,
        data: email.toJson());

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

  
  Future<Result<List<SaveUser>>> getSaveUserList() async {
    var response = await apiService.post<List<dynamic>>(

        /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.getSaveUserList,
        fromJsonT: SaveUser.fromJson,
        data: <String, dynamic>{
          "user_id_of_main_user": getString(PreferenceConstant.userId),
          "user_id": getString(PreferenceConstant.userId)
        });

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(
            (result.data as List<dynamic>).map((e) => e as SaveUser).toList());
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<ResGroup>> addGroupMember(
      ReqAddGroupMember addGroupMember) async {
    var response = await apiService.post<ResGroup>(
        DioApiConstants.groupAddNumber,
        fromJsonT: ResGroup.fromJson,
        data: addGroupMember.toJson());

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

  
  Future<Result<ResGroup>> getGroupDetail(ReqGroupDetail reqGroupDetail) async {
    var response = await apiService.post<ResGroup>(DioApiConstants.groupDetails,
        fromJsonT: ResGroup.fromJson, data: reqGroupDetail.toJson());

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

  
  Future<Result<List<ResGroup>>> getGroups() async {
    var response = await apiService.post<List<dynamic>>(

        /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.groupList,
        fromJsonT: ResGroup.fromJson);

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(
            (result.data as List<dynamic>).map((e) => e as ResGroup).toList());
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<String>> registerGroup(
      ReqRegisterGroup reqRegisterGroup) async {
    var response = await apiService.post<String>(DioApiConstants.groupRegister,
        fromJsonT: null, data: reqRegisterGroup.toJson());

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success(result.description ?? 'Add Successfully');
      } else {
        throw Exception(result.description);
      }
    } else {
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  
  Future<Result<ResGroup>> updateGroup(
      ReqRegisterGroup reqRegisterGroup) async {
    var response = await apiService.post<ResGroup>(DioApiConstants.groupUpdate,
        fromJsonT: ResGroup.fromJson, data: reqRegisterGroup.toJson());

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
