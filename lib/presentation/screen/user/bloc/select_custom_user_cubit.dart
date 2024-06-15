import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';

import '../../../../base/result.dart';
import '../../../../domain/model/response/res_project.dart';
import '../../../../domain/repository/save_user_repository.dart';

class SelectCustomUserCubit extends BaseCubit<BaseState, String>{

  final SaveUserRepository _saveUserRepository;
  SelectCustomUserCubit(this._saveUserRepository) : super(BaseInitState() , "");

  List<ProjectMember> selectedMembers = [];

  final List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];


  List<SaveUser> saveUserList = [];

  Future<void> getSaveUserList() async {
    if (isBusy) return;

    try{
      emit(LoadingState());
      var response = await _saveUserRepository.getSaveUserList();
      if(response is Success){
        saveUserList.addAll(((response as Success).data as List<SaveUser>));
        emit(SaveUserListState());
      }else{
        emit(ErrorState(errorMessage: (response as Error).errorResponse.errorMessage));
      }
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  void initSelectList(List<ProjectMember> intiList){
    selectedMembers.clear();
    selectedMembers.addAll(intiList);
    emit(RefreshState());
  }

  void addUser(SaveUser customUser , String customName , List<String> roles) {
    var projectMember = ProjectMember(userId: customUser.displayName ??'', role: customUser.roles?.join(",") ?? '', sId: customUser.sId , userName: customName);

      int index =
      selectedMembers.indexWhere((data) => data.userId == projectMember.userId);

      if (index != -1) {
        selectedMembers[index] = projectMember;
      } else {
        selectedMembers.add(projectMember);
      }
  }
}