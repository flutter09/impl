import 'package:bloc/bloc.dart';
import 'package:chat_application/base/base_state.dart';
import 'package:meta/meta.dart';

import '../../base/base_cubit.dart';
import '../../base/result.dart';
import '../../domain/model/request/login_request.dart';
import '../../domain/model/response/login_response.dart';
import '../../domain/repository/user_repository.dart';

part 'singin_state.dart';

class SignInCubit extends BaseCubit<BaseState , String>{
  final UserRepository _userRepository;

  SignInCubit(this._userRepository) : super(BaseInitState(), "");

  Future<void> login(String email, String password) async {
    if (isBusy) return;

    await run(() async {
      emit(LoadingState());
      try {
        final response = await _userRepository.login(
            LoginRequest(email, password)
        );

        if (response is Success)  {
          final token = ((response as Success).data as LoginResponse).token;
          emit(SignInState(token: token!));
        }
      }catch(e){
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
  }
}
