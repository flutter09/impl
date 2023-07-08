

import '../../base/result.dart';
import '../../domain/model/request/login_request.dart';
import '../../domain/model/response/error_response.dart';
import '../../domain/model/response/login_response.dart';
import '../../domain/repository/user_repository.dart';
import '../remote/api_constant.dart';
import '../remote/api_service.dart';

class UserRepositoryImpl implements UserRepository{
  final ApiService apiService;
  UserRepositoryImpl({required this.apiService});
  @override
  Future<Result<LoginResponse>> login(LoginRequest request) async {
    var response = await apiService.post(DioApiConstants.login , data : request.toJson());
    if(response?.statusCode == 200) {
      return Success(LoginResponse.fromJson(response?.data));
    }else{
      throw Exception(ErrorResponse.fromJson(response?.data ?? {"error","null response found"}).errorMessage);
    }
  }
}