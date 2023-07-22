import 'package:bloc/bloc.dart';
import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/base/result.dart';
import 'package:chat_application/domain/model/request/req_check_otp.dart';
import 'package:chat_application/domain/model/request/req_forgot_password.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../../../domain/repository/user_repository.dart';


class ForgotPasswordCubit extends BaseCubit<BaseState , String> {
  final UserRepository _userRepository;
  ForgotPasswordCubit(this._userRepository) : super(BaseInitState(),"");

  final mailController = TextEditingController();
  final otpController = TextEditingController();

  Future<void> sendOtp() async {
    if(isBusy) return;

    try{
      emit(LoadingState());
      final response = await _userRepository.sendOtp(
          ReqSendOtp(email: mailController.text)
      );
      if(response is Success){
        emit(ForgotPasswordState());
      }
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> verifyOtp() async {
    if(isBusy) return;

    try{
      emit(LoadingState());
      final response = await _userRepository.verifyOtp(
          ReqCheckOtp(email: mailController.text , emailOtp: otpController.text)
      );
      if(response is Success){
        emit(ForgotPasswordState());
      }
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
