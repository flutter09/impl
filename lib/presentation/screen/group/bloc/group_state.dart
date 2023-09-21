import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/response/res_group.dart';

class RegisterGroupState extends BaseState {
  final String msg;
  RegisterGroupState({required this.msg});
}

class GetGroupsState extends BaseState {

}

class GroupDetailState extends BaseState {
  final ResGroup resGroup;
  GroupDetailState({required this.resGroup});
}

class UpdateGroupDetailState extends BaseState {

}

class AddGroupMemberState extends BaseState {

}