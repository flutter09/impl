import 'package:chat_application/domain/model/request/req_add_save_user.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/domain/model/response/search_user_model.dart';

import '../../base/result.dart';

abstract class SaveUserRepository{
  Future<Result<SearchUserData>> getSaveUser(ReqSendOtp email);
  Future<Result<String>> addSaveUser(ReqAddSaveUser reqAddSaveUser);
  Future<Result<String>> editSaveUser(ReqAddSaveUser reqAddSaveUser);
  Future<Result<List<SaveUser>>> getSaveUserList();
}