import 'package:chat_application/domain/model/request/req_add_project_member.dart';
import 'package:chat_application/domain/model/request/req_project_detail.dart';
import 'package:chat_application/domain/model/request/req_register_project.dart';

import '../../base/result.dart';
import '../model/response/res_project.dart';

abstract class ProjectRepository{
  Future<Result<String>> registerProject(ReqRegisterProject registerProject);
  Future<Result<List<ResProject>>> getProjects();
  Future<Result<ResProject>> getProjectDetail(ReqProjectDetail reqProjectDetail);
  Future<Result<ResProject>> updateProject(ResProject resProject);
  Future<Result<ResProject>> addProjectMember(ReqAddProjectMember reqAddProjectMember);
}