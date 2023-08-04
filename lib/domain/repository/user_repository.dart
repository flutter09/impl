import 'dart:io';

import 'package:chat_application/domain/model/request/req_check_otp.dart';
import 'package:chat_application/domain/model/request/req_forgot_password.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/domain/model/request/req_user_detail.dart';
import 'package:chat_application/domain/model/request/req_user_register.dart';

import '../../base/result.dart';
import '../model/request/req_login.dart';
import '../model/response/res_user_model.dart';

abstract class UserRepository{
  Future<Result<ResUserModel>> login(ReqLogin request);
  Future<Result<ResUserModel>> registerUser(ReqUserRegister reqUserRegister , File? file);
  Future<Result<String>> forgotPassword(ReqForgotPassword reqForgotPassword);
  Future<Result<ResUserModel>> verifyOtp(ReqCheckOtp reqCheckOtp );
  Future<Result<String>> sendOtp(ReqSendOtp reqSendOtp);
  Future<Result<String>> uploadFile(File file , Map<String , dynamic> fields);
  Future<Result<String>> downloadFile(String fileUrl , Map<String , dynamic> fields);

  Future<Result<ResUserModel>> getUserDetails();
  Future<Result<String>> updateUserDetails(ReqUserDetail reqUserDetail , File? file);


// Future<dynamic> getAllWallets(int page,String? searchText);
// Future<dynamic> addWallet(String userKey,String walletId,String? publicKey);
// Future<dynamic> removeWallet(String userKey,String walletId);
// Future<dynamic> getUserWallet(String userKey);
// Future<dynamic> walletChart(String days);
// Future<dynamic> walletTransactionData(String senderKey, String receiverKey, double amount);

}