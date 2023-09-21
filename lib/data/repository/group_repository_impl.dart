import 'package:chat_application/base/result.dart';
import 'package:chat_application/domain/model/request/req_add_group_member.dart';
import 'package:chat_application/domain/model/request/req_group_detail.dart';
import 'package:chat_application/domain/model/request/req_register_group.dart';
import 'package:chat_application/domain/model/response/res_group.dart';
import 'package:chat_application/domain/repository/group_repository.dart';

import '../../base/api_response.dart';
import '../remote/api_constant.dart';
import '../remote/api_service.dart';

class GroupRepositoryImpl extends GroupRepository {
  final ApiService apiService;

  GroupRepositoryImpl({required this.apiService});

  @override
  Future<Result<ResGroup>> addGroupMember(ReqAddGroupMember addGroupMember) async {
    var response = await apiService.post<ResGroup>(
        DioApiConstants.groupAddNumber, ResGroup.fromJson,
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

  @override
  Future<Result<ResGroup>> getGroupDetail(ReqGroupDetail reqGroupDetail) async {
    var response = await apiService.post<ResGroup>(
        DioApiConstants.groupDetails, ResGroup.fromJson,
        data: reqGroupDetail.toJson());

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
  Future<Result<List<ResGroup>>> getGroups() async {
    var response = await apiService.post<List<dynamic>>(
      /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.groupList, ResGroup.fromJson
    );

    if (response is Success) {
      var result = (response as Success).data as ApiResponse;
      if (result.success ?? false) {
        return Success((result.data as List<dynamic>).map((e) => e as ResGroup).toList());
      } else {
        throw Exception(result.description);
      }
    } else {
      print('repo mapping');
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<String>> registerGroup(ReqRegisterGroup reqRegisterGroup) async {
    var response = await apiService.post<String>(
        DioApiConstants.groupRegister, null,
        data: reqRegisterGroup.toJson());

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

  @override
  Future<Result<ResGroup>> updateGroup(ReqRegisterGroup reqRegisterGroup) async {
    var response = await apiService.post<ResGroup>(
        DioApiConstants.groupUpdate, ResGroup.fromJson,
        data: reqRegisterGroup.toJson());

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