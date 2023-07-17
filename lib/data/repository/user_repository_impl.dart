

import '../../base/result.dart';
import '../../base/api_response.dart';
import '../../domain/model/request/req_login.dart';
import '../../domain/model/response/error_response.dart';
import '../../domain/model/response/res_user_model.dart';
import '../../domain/repository/user_repository.dart';
import '../remote/api_constant.dart';
import '../remote/api_service.dart';

class UserRepositoryImpl implements UserRepository{
  final ApiService apiService;
  UserRepositoryImpl({required this.apiService });

  @override
  Future<Result<ResUserModel>> login(ReqLogin request) async {
    var response = await apiService.post<ResUserModel>(DioApiConstants.login ,ResUserModel.fromJson, data : request.toJson());
    if(response is Success) {
      var result = (response as Success).data as ApiResponse;
      print(result.data);
      if(result.success ?? false) {
        return Success(result.data);
      } else {
        throw Exception(ErrorResponse.fromCode(result.message ?? 0).errorMessage);
      }
    }else{
      throw Exception((response as Error).errorResponse.errorMessage);
    }
  }

  @override
  Future<Result<ResUserModel>> forgotPassword(ReqLogin request) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<Result<ResUserModel>> registerUser(ReqLogin request) {
    // TODO: implement registerUser
    throw UnimplementedError();
  }

  @override
  Future<Result<ResUserModel>> verifyOtp(ReqLogin request) {
    // TODO: implement verifyOtp
    throw UnimplementedError();
  }
}