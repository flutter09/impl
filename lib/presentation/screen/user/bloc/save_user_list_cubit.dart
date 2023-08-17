import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/domain/model/response/res_user_model.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';
import 'package:chat_application/utils/extensions.dart';

import '../../../../base/base_state.dart';
import '../../../../base/result.dart';
import '../../../../domain/repository/user_repository.dart';

class SaveUserListCubit extends BaseCubit<BaseState , String>{
  final UserRepository _userRepository;

  SaveUserListCubit(this._userRepository) : super(BaseInitState(), "");

  List<UserSaveData> saveUserList = [];

  Future<void> getSaveUserList() async {
    if (isBusy) return;

    try{
      emit(LoadingState());
      var response = await _userRepository.getUserDetails();
      if(response is Success){
        saveUserList.addAll(((response as Success).data as ResUserModel).userSaveId?.getNonNullList() ?? []);
        emit(SaveUserListState(saveUserList: ((response as Success).data as ResUserModel).userSaveId?.getNonNullList() ?? [], ));
      }else{
        emit(ErrorState(errorMessage: (response as Error).errorResponse.errorMessage));
      }
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

}