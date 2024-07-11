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
import '../../../../data/repository/common_repository.dart';
import '../../../../domain/model/response/save_user_model.dart';
import '../../../../domain/repository/project_repository.dart';
import '../../../../domain/repository/save_user_repository.dart';

enum Role{
  developer(name: 'Developer'),
  projectManager(name: 'Project Manager'),
  client(name: 'Client'),
  other(name: 'Other'),
  creator(name: 'Creator');

  final String name;
  const Role({required this.name});
}

class ProjectCubit extends BaseCubit<BaseState, String> {
  final ProjectRepository projectRepository;
  final PreferenceRepository preferenceRepository;
  final CommonRepository commonRepository;

  ProjectCubit(this.projectRepository, this.preferenceRepository, this.commonRepository) : super(BaseInitState(), "");

  //project list screen
  List<Project> projectList = [];
  List<Project> otherProjectList = [];

  // create project screen
  final projectNameController = TextEditingController();
  final projectDescController = TextEditingController();


  void removeUser(ProjectMember resProjectMember) {
    projectMemberList.remove(resProjectMember);
  }

  // update project
  Project? editingProject;
  final updateProjectNameController = TextEditingController();
  final updateProjectDescriptionController = TextEditingController();

  // add member
  ProjectMember? resProjectMember;
  final memberCustomNameController = TextEditingController();
  final memberCustomRoleController = TextEditingController();

  Future<void> registerProject() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      List<ProjectMember> projectMembers = List.from(projectMemberList);
      projectMembers.add(
        ProjectMember(
          chatName: preferenceRepository.getUser().firstName,
          addedByUserId: preferenceRepository.getUserId(),
          userId: preferenceRepository.getUserId(),
          userName: preferenceRepository.getUser().firstName,
          role: Role.creator.name,
        )
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
      var response = await projectRepository.getMyProject();
      if (response is Success) {
        projectList.clear();
        projectList.addAll(((response as Success).data as OurProjectList).project?.nonNulls ?? []);
        emit(GetProjects());
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getOtherProject() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response = await projectRepository.getOtherProject();
      if (response is Success) {
            otherProjectList.addAll(((response as Success).data as ProjectList).project?.nonNulls ?? []);
        emit(RefreshState());
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

  /*Future<void> addProjectMember() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response =
          await projectRepository.addProjectMember(ReqAddProjectMember(
              projectId: editingProject?.sId ?? "",
              userDetails: UserDetails(
                userId: resProjectMember?.sId ?? "",
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
  }*/


  final List<ProjectMember> projectMemberList = [];
  void addProjectMember({SaveUser? saveUser, String? chatName, String? role}) {
    projectMemberList.add(
        ProjectMember(
          userId: saveUser?.sId,
          userName: saveUser?.firstName,
          chatName: chatName,
          role: role,
          addedByUserId: preferenceRepository.getUserId(),
        )
    );
    emit(RefreshState());
  }



  List<SaveUser> saveUserList = [];

  Future<void> getSaveUserList() async {
    if (isBusy) return;

    try{
      emit(LoadingState());
      var response = await commonRepository.getSaveUserList();
      if(response is Success){
        saveUserList.clear();
        saveUserList.addAll((response as Success).data as List<SaveUser>);
        emit(RefreshState());
      }else{
        emit(ErrorState(errorMessage: (response as Error).errorResponse.errorMessage));
      }
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}