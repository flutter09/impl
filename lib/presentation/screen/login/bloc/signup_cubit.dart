import 'dart:io';

import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/base_state.dart';
import '../../../../base/result.dart';
import '../../../../data/local/preference_repository.dart';
import '../../../../domain/model/request/req_user_register.dart';
import '../../../../domain/model/response/res_user_model.dart';
import '../../../../domain/repository/user_repository.dart';


class SignUpCubit extends BaseCubit<BaseState , String> {
  final UserRepository _userRepository;
  final PreferenceRepository _preferenceRepository;

  SignUpCubit(this._userRepository,this._preferenceRepository) : super(BaseInitState(),"");

  Future<void> registerUser(String name , String email , String phone , String password , File? file) async {
    if (isBusy) return;

    await run(() async {
      emit(LoadingState());
      try {
        final response = await _userRepository.registerUser(
            ReqUserRegister(name:name , email:email , phone: phone , password: password),
          file
        );
        if (response is Success) {
          final token = ((response as Success).data as ResUserModel).token;
          _preferenceRepository.setAccessToken(token ?? "");
          emit(const SignUpState(register: true));
        }
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
  }
}
