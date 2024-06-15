import 'package:chat_application/domain/model/request/req_add_project_member.dart';
import 'package:chat_application/domain/model/request/req_project_detail.dart';
import 'package:chat_application/domain/model/request/req_register_project.dart';

import '../../base/result.dart';
import '../model/response/res_project.dart';

abstract class ProjectRepository{
  Future<Result<String>> registerProject(ReqRegisterProject registerProject);
  Future<Result<Project>> getProjectDetail(ReqProjectDetail reqProjectDetail);
  Future<Result<Project>> updateProject(Project resProject);
  Future<Result<Project>> addProjectMember(ReqAddProjectMember reqAddProjectMember);
  Future<Result<OurProjectList>> getMyProject();
  Future<Result<FavouriteProjectList>> getMyFavouriteProject();
  Future<Result<ProjectList>> getOtherProject();
  Future<Result<FavouriteProjectList>> getOtherFavouriteProject();
}