import 'package:chat_application/presentation/screen/login/bloc/singin_state.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/base_state.dart';
import '../../../../base/result.dart';
import '../../../../domain/model/request/req_user_register.dart';
import '../../../../domain/repository/user_repository.dart';


class SignUpCubit extends BaseCubit<BaseState , String> {
  final UserRepository _userRepository;

  SignUpCubit(this._userRepository) : super(BaseInitState(),"");

  Future<void> registerUser(String name , String email , String phone , String password) async {
    if (isBusy) return;

    await run(() async {
      emit(LoadingState());
      try {
        final response = await _userRepository.registerUser(ReqUserRegister(name:name , email:email , phone: phone , password: password));
        if (response is Success) {
          emit(const SignUpState(register: true));
        }
      } catch (e) {
        emit(ErrorState(errorMessage: e.toString()));
      }
    });
  }
}
