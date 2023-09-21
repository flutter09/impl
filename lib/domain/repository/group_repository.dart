import 'package:chat_application/domain/model/request/req_add_group_member.dart';
import 'package:chat_application/domain/model/request/req_group_detail.dart';
import 'package:chat_application/domain/model/request/req_register_group.dart';
import 'package:chat_application/domain/model/response/res_group.dart';

import '../../base/result.dart';

abstract class GroupRepository {
  Future<Result<String>> registerGroup(ReqRegisterGroup reqRegisterGroup);
  Future<Result<List<ResGroup>>> getGroups();
  Future<Result<ResGroup>> getGroupDetail(ReqGroupDetail reqGroupDetail);
  Future<Result<ResGroup>> updateGroup(ReqRegisterGroup reqRegisterGroup);
  Future<Result<ResGroup>> addGroupMember(ReqAddGroupMember addGroupMember);
}