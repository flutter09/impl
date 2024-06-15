import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/response/res_project.dart';

class RegisterProjectState extends BaseState {
  final String msg;
  RegisterProjectState({required this.msg});
}

class GetProjects extends BaseState {

}

class GetProjectDetail extends BaseState {
  final Project resProject;
  GetProjectDetail({required this.resProject});
}

class UpdateProject extends BaseState {

}

class AddProjectMember extends BaseState {

}