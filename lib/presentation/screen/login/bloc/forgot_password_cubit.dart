import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';
import 'package:chat_application/base/result.dart';
import 'package:chat_application/domain/model/request/req_check_otp.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';
import 'package:flutter/cupertino.dart';

import '../../../../data/local/preference_repository.dart';
import '../../../../domain/model/response/res_user_model.dart';
import '../../../../domain/repository/user_repository.dart';

class ForgotPasswordCubit extends BaseCubit<BaseState, String> {
  final UserRepository _userRepository;
  final PreferenceRepository _preferenceRepository;

  ForgotPasswordCubit(this._userRepository , this._preferenceRepository) : super(BaseInitState(), "");

  final mailController = TextEditingController();
  final otpController = TextEditingController();

  Future<void> sendOtp(String mail) async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      final response =
          await _userRepository.sendOtp(ReqSendOtp(email: mail));
      if (response is Success) {
        emit(ForgotPasswordState());
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> verifyOtp(String mail) async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      final response = await _userRepository
          .verifyOtp(ReqCheckOtp(email: mail, emailOtp: otpController.text));
      if (response is Success) {
        final user = ((response as Success).data as ResUserModel);
        _preferenceRepository.setAccessToken(user.tokens?.last ?? "");
        _preferenceRepository.setUserId(user.id ?? "");
        emit(OtpVerifiedState());
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }
}
