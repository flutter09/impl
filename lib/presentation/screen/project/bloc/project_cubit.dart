import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/request/req_add_project_member.dart';
import 'package:chat_application/domain/model/request/req_project_detail.dart';
import 'package:chat_application/domain/model/request/req_register_project.dart';
import 'package:chat_application/domain/model/response/res_project.dart';
import 'package:chat_application/presentation/screen/project/bloc/project_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../../base/result.dart';
import '../../../../data/local/preference_repository.dart';
import '../../../../domain/repository/project_repository.dart';

class ProjectCubit extends BaseCubit<BaseState, String> {
  final ProjectRepository projectRepository;
  final PreferenceRepository preferenceRepository;

  ProjectCubit(this.projectRepository, this.preferenceRepository) : super(BaseInitState(), "");

  //project list screen
  List<ResProject> projectList = [];

  // create project screen
  final projectNameController = TextEditingController();
  final startDateController = TextEditingController();
  final endDateController = TextEditingController();
  final projectDescController = TextEditingController();
  final budgetController = TextEditingController();
  final priorityController = TextEditingController();
  final categoryController = TextEditingController();
  final imageController = TextEditingController();

  final List<ResProjectMember> selectedMembers = [];

  void updateSelectedProjectMember(List<ResProjectMember>? resultList) {
    selectedMembers.clear();
    selectedMembers.addAll(resultList ?? []);
  }

  void removeUser(ResProjectMember resProjectMember) {
    selectedMembers.remove(resProjectMember);
  }

  // update project
  ResProject? editingProject;
  final updateProjectNameController = TextEditingController();
  final updateProjectDescriptionController = TextEditingController();

  // add member
  ResProjectMember? resProjectMember;
  final memberCustomNameController = TextEditingController();
  final memberCustomRoleController = TextEditingController();

  Future<void> registerProject() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var projectMembers = selectedMembers
          .map((e) => ReqProjectMember(
          userId: e.userId ??'',
          userName: e.customName ?? "",
          role: e.customRole ?? "")
      ).toList();
      projectMembers.add(
        ReqProjectMember(userId: preferenceRepository.getUserId(), userName: preferenceRepository.getUserName(), role: '1',)
      );
      
      var response = await projectRepository.registerProject(ReqRegisterProject(
          name: projectNameController.text,
          description: projectDescController.text,
          projectMembers: projectMembers
      ));
      if (response is Success) {
        emit(RegisterProjectState(msg: (response as Success).data));
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getProjects() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response = await projectRepository.getProjects();
      if (response is Success) {
        print('cubit sucess');
        projectList.clear();
        projectList.addAll((response as Success).data);
        emit(GetProjects());
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getProjectDetail(String projectId) async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response = await projectRepository
          .getProjectDetail(ReqProjectDetail(projectId: projectId));
      if (response is Success) {
        emit(GetProjectDetail(resProject: (response as Success).data));
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> updateProject() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      editingProject?.name = updateProjectDescriptionController.text;
      editingProject?.description = updateProjectDescriptionController.text;
      var response = await projectRepository.updateProject(editingProject!);
      if (response is Success) {
        emit(GetProjectDetail(resProject: (response as Success).data));
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> addProjectMember() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response =
          await projectRepository.addProjectMember(ReqAddProjectMember(
              projectId: editingProject?.id ?? "",
              userDetails: UserDetails(
                userId: resProjectMember?.id ?? "",
                userName: memberCustomNameController.text,
                role: memberCustomRoleController.text,
              )));
      if (response is Success) {
        emit(GetProjectDetail(resProject: (response as Success).data));
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}