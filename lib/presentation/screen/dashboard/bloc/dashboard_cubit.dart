import 'package:chat_application/base/extension/list_extension.dart';
import 'package:chat_application/domain/model/response/res_project.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/base_state.dart';
import '../../../../base/result.dart';
import '../../../../data/repository/common_repository.dart';
import '../../../../domain/repository/project_repository.dart';
import '../../../../domain/repository/save_user_repository.dart';

enum GridData{
  MyProject('My Project'),
  OtherProject('Other Project'),
  Members('Members'),
  TodaysEvent('Today\'s event');

  final String title;
  const GridData(this.title);
}

class DashboardCubit extends BaseCubit<BaseState, String> {
  final CommonRepository commonRepository;
  final ProjectRepository projectRepository;
  final SaveUserRepository saveUserRepository;
  DashboardCubit(this.commonRepository, this.projectRepository, this.saveUserRepository) : super(BaseInitState(), "");



  final List<Map<String, String>> gridData = [
    {
      'title' : GridData.MyProject.title,
    },
    {
      'title' : GridData.OtherProject.title,
    },
    {
      'title' : GridData.Members.title,
    },
    {
      'title' :  GridData.TodaysEvent.title,
    },
  ];

  void addDescriptionByTitle(String title, String description) {
    var item = gridData.firstWhereOrNull((e)=> e['title'] == title);
    if(item != null){
      item['description'] = description;
    }else{
      gridData.add({
        'title' : title,
        'description' : description
      });
    }
  }

  List<Project> favouriteProject = [];
  List<Project> favouriteOtherProject = [];

  Future<void> getFavouriteProject() async {
    if (isBusy) return;
    try {
      emit(LoadingState());
      var response = await projectRepository.getMyFavouriteProject();
      if (response is Success) {
        favouriteProject.clear();
        favouriteProject.addAll(((response as Success).data as FavouriteProjectList).project?.nonNulls ?? []);
        emit(RefreshState());
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getOtherFavouriteProject() async {
    if (isBusy) return;
    try {
      emit(LoadingState());
      var response = await projectRepository.getOtherFavouriteProject();
      if (response is Success) {
        favouriteOtherProject.clear();
        favouriteOtherProject.addAll(((response as Success).data as FavouriteProjectList).project?.nonNulls ?? []);
        emit(RefreshState());
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getProject() async{
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response = await projectRepository.getMyProject();
      if (response is Success) {
        addDescriptionByTitle(
          GridData.MyProject.title,
            (((response as Success).data as OurProjectList).project?.length ?? 0).toString()
        );

        emit(RefreshState());
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
        addDescriptionByTitle(
            GridData.OtherProject.title,
            (((response as Success).data as ProjectList).project?.length ?? 0).toString()
        );

        emit(RefreshState());
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> getSaveUserList() async {
    if (isBusy) return;

    try{
      emit(LoadingState());
      var response = await saveUserRepository.getSaveUserList();
      if(response is Success){
        addDescriptionByTitle(GridData.Members.title, (((response as Success).data as List<SaveUser>).length ?? 0).toString());
        emit(RefreshState());
      }else{
        emit(ErrorState(errorMessage: (response as Error).errorResponse.errorMessage));
      }
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

}