import 'package:chat_application/domain/model/request/req_forgot_password.dart';
import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';
import 'package:flutter/material.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/base_state.dart';
import '../../../../base/result.dart';
import '../../../../domain/repository/user_repository.dart';

class GeneratePasswordCubit extends BaseCubit<BaseState , String> {
  final UserRepository _userRepository;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  GeneratePasswordCubit(this._userRepository) : super(BaseInitState(),"");

  Future<void> generatePassword(String email , String password) async {
    if (isBusy) return;

    await run(() async {
      emit(LoadingState());
      try {
        final response = await _userRepository.forgotPassword(
          ReqForgotPassword(email: email, password: password)
        );
        if (response is Success) {
          emit(GeneratePasswordState());
        }
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
  }

}