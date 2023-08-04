import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/domain/model/response/res_user_model.dart';

class UserState extends BaseState{
  final ResUserModel resUserModel;
  const UserState({
    required this.resUserModel
});
}

class UserUpdateState extends BaseState{
  final String message;
  const UserUpdateState({
    required this.message
});
}