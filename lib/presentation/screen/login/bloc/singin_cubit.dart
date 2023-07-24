import 'dart:io';

import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/result.dart';
import '../../../../data/local/preference_repository.dart';
import '../../../../domain/model/request/req_login.dart';
import '../../../../domain/model/response/res_user_model.dart';
import '../../../../domain/repository/user_repository.dart';

class SignInCubit extends BaseCubit<BaseState, String> {
  final UserRepository _userRepository;
  final PreferenceRepository _preferenceRepository;

  SignInCubit(this._userRepository, this._preferenceRepository)
      : super(BaseInitState(), "");

  Future<void> checkLoginF() async {
    emit(LoadingState());
    var token = await _preferenceRepository.getAccessToken();
    if (token.isNotEmpty) {
      emit(SignInState(token: token));
    }
    emit(const ErrorState(errorMessage: ""));
  }

  bool checkLogin() {
    var token = _preferenceRepository.getAccessToken();
    return token.isNotEmpty;
  }

  Future<void> login(String email, String password) async {
    if (isBusy) return;

    await run(() async {
      emit(LoadingState());
      try {
        final response = await _userRepository
            .login(ReqLogin(email: email, password: password));

        if (response is Success) {
          final token = ((response as Success).data as ResUserModel).token;
          _preferenceRepository.setAccessToken(token ?? "");
          emit(SignInState(token: token ?? ""));
        }
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
  }

  Future<void> uploadFile(File? file) async {
    if (isBusy) return;

    await run(() async {
      emit(LoadingState());
      try {
        final response =
            await _userRepository.uploadFile(file!, {"name": "hi"});

        if (response is Success) {
          emit(ErrorState(errorMessage: (response as Success).data.toString()));
        }
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
  }
}
