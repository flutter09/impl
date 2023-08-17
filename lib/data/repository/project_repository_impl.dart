import 'package:chat_application/base/result.dart';
import 'package:chat_application/data/remote/api_constant.dart';
import 'package:chat_application/domain/model/request/req_project_detail.dart';
import 'package:chat_application/domain/model/request/req_register_project.dart';
import 'package:chat_application/domain/model/response/res_project.dart';
import 'package:chat_application/domain/repository/project_repository.dart';

import '../../base/api_response.dart';
import '../../domain/model/response/error_response.dart';
import '../remote/api_service.dart';

class ProjectRepositoryImpl extends ProjectRepository{
  final ApiService apiService;

  ProjectRepositoryImpl({required this.apiService});

  @override
  Future<Result<ResProject>> addProjectMember(ReqProjectMember reqProjectMember) async {
    var response = await apiService.post<ResProject>(
        DioApiConstants.projectAddMembers, ResProject.fromJson,
        data: reqProjectMember.toJson());

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
  Future<Result<ResProject>> getProjectDetail(ReqProjectDetail reqProjectDetail) async {
    var response = await apiService.post<ResProject>(
        DioApiConstants.projectAddMembers, ResProject.fromJson,
        data: reqProjectDetail.toJson());

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
  Future<Result<List<ResProject>>> getProjects() async {
    var response = await apiService.post<List<ResProject>>(
        DioApiConstants.projectRegister, ResProject.fromJson
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
  Future<Result<String>> registerProject(ReqRegisterProject registerProject) async {
    var response = await apiService.post<String>(
        DioApiConstants.projectRegister, null,
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

  @override
  Future<Result<ResProject>> updateProject(ResProject resProject) async {
    var response = await apiService.post<ResProject>(
        DioApiConstants.projectUpdate, ResProject.fromJson,
        data: resProject.toJson());

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