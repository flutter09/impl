import 'package:chat_application/base/result.dart';
import 'package:chat_application/data/remote/api_constant.dart';
import 'package:chat_application/domain/model/request/req_project_detail.dart';
import 'package:chat_application/domain/model/request/req_register_project.dart';
import 'package:chat_application/domain/model/response/res_project.dart';
import 'package:chat_application/domain/repository/project_repository.dart';

import '../../base/api_response.dart';
import '../../domain/model/request/req_add_project_member.dart';
import '../remote/api_service.dart';

class ProjectRepositoryImpl extends ProjectRepository{
  final ApiService apiService;

  ProjectRepositoryImpl({required this.apiService});

  @override
  Future<Result<Project>> addProjectMember(ReqAddProjectMember reqAddProjectMember) async {
    var response = await apiService.post<Project>(
        DioApiConstants.projectAddMembers, fromJsonT: Project.fromJson,
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

  @override
  Future<Result<Project>> getProjectDetail(ReqProjectDetail reqProjectDetail) async {
    var response = await apiService.post(
        DioApiConstants.projectDetails,
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

  @override
  Future<Result<String>> registerProject(ReqRegisterProject registerProject) async {
    var response = await apiService.post<String>(
        DioApiConstants.projectRegister, fromJsonT: null,
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
  Future<Result<Project>> updateProject(Project resProject) async {
    var response = await apiService.post<Project>(
        DioApiConstants.projectUpdate,fromJsonT:  Project.fromJson,
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

  Future<Result<OurProjectList>> getMyProject() async {
    var response = await apiService.post<OurProjectList>(
      /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.ourProjectList, fromJsonT: OurProjectList.fromJson
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

  Future<Result<FavouriteProjectList>> getMyFavouriteProject() async {
    var response = await apiService.post<FavouriteProjectList>(
      /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.ourFavouriteProject, fromJsonT: FavouriteProjectList.fromJson
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

  Future<Result<ProjectList>> getOtherProject() async {
    var response = await apiService.post<ProjectList>(
      /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.projectList, fromJsonT: ProjectList.fromJson
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

  Future<Result<FavouriteProjectList>> getOtherFavouriteProject() async {
    var response = await apiService.post<FavouriteProjectList>(
      /// list class is not able to directly cast so we can cast each element sapratly
        DioApiConstants.favouriteProject, fromJsonT: FavouriteProjectList.fromJson
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