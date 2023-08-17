import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/response/res_user_model.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';

class UserState extends BaseState {
  final ResUserModel resUserModel;

  const UserState({required this.resUserModel});
}

class UserUpdateState extends BaseState {
  final String message;

  const UserUpdateState({required this.message});
}

class SaveUserState extends BaseState {
  final SaveUserModel saveUserModel;

  const SaveUserState({required this.saveUserModel});
}

class AddSaveUserState extends BaseState {
  final String? message;

  const AddSaveUserState({required this.message});
}

class UpdateSaveUserState extends BaseState {
  final String? message;

  const UpdateSaveUserState({required this.message});
}

class SaveUserListState extends BaseState {
  final List<UserSaveData> saveUserList;

  const SaveUserListState({required this.saveUserList});
}