import '../../base/result.dart';
import '../model/request/req_login.dart';
import '../model/response/res_user_model.dart';

abstract class UserRepository{
  Future<Result<ResUserModel>> login(ReqLogin request);
  Future<Result<ResUserModel>> registerUser(ReqLogin request);
  Future<Result<ResUserModel>> forgotPassword(ReqLogin request);
  Future<Result<ResUserModel>> verifyOtp(ReqLogin request);

// Future<dynamic> getAllWallets(int page,String? searchText);
// Future<dynamic> addWallet(String userKey,String walletId,String? publicKey);
// Future<dynamic> removeWallet(String userKey,String walletId);
// Future<dynamic> getUserWallet(String userKey);
// Future<dynamic> walletChart(String days);
// Future<dynamic> walletTransactionData(String senderKey, String receiverKey, double amount);

}