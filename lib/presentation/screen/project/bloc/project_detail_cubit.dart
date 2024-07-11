import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';

import '../../../../base/result.dart';
import '../../../../domain/model/request/req_project_detail.dart';
import '../../../../domain/model/response/res_project.dart';
import '../../../../domain/repository/project_repository.dart';

class ProjectDetailCubit extends BaseCubit<BaseState, String>{
  final ProjectRepository projectRepository;
  ProjectDetailCubit(this.projectRepository): super(BaseInitState(), '');

  Project? project;

  Future<void> getProjectDetails(String projectId) async {
    if (isBusy) return;
    try {
      emit(LoadingState());
      var response = await projectRepository
          .getProjectDetail(ReqProjectDetail(projectId: projectId));
      if (response is Success) {
        project = (response as Success).data;
        emit(RefreshState());
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  void editProject() {}

  void deleteProject() {}


}