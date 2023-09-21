import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/request/req_register_group.dart';
import 'package:chat_application/domain/model/response/res_group.dart';
import 'package:chat_application/presentation/screen/group/bloc/group_state.dart';

import '../../../../base/result.dart';
import '../../../../domain/repository/group_repository.dart';
import '../../../../domain/repository/user_repository.dart';

class GroupCubit extends BaseCubit<BaseState, String> {
  final GroupRepository groupRepository;
  final UserRepository userRepository;

  GroupCubit(this.groupRepository, this.userRepository)
      : super(BaseInitState(), "");

  List<ResGroup> groupList = [];

  Future<void> getGroups() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response = await groupRepository.getGroups();
      if (response is Success) {
        print('cubit sucess');
        groupList.clear();
        groupList.addAll((response as Success).data);
        emit(GetGroupsState());
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> registerGroup(String projectId , String name , String description , List<ReqGroupMember>? groupMembers,) async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response = await groupRepository.registerGroup(ReqRegisterGroup(
          projectId: projectId,
          name: name,
          description: description,
          groupMembers: groupMembers, groupId: ''
      ));
      if (response is Success) {
        emit(RegisterGroupState(msg: (response as Success).data));
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
