import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';

import '../../../../domain/model/response/res_project.dart';
import '../../../../domain/repository/project_repository.dart';

class ProjectDetailCubit extends BaseCubit<BaseState, String>{
  final ProjectRepository projectRepository;
  ProjectDetailCubit(this.projectRepository): super(BaseInitState(), '');

  Project? project;

  void getProjectDetails() {}

  void editProject() {}

  void deleteProject() {}


}