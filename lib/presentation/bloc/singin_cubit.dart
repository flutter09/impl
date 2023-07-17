import 'package:chat_application/base/base_state.dart';

import '../../base/base_cubit.dart';
import '../../base/result.dart';
import '../../data/local/preference_repository.dart';
import '../../domain/model/request/req_login.dart';
import '../../domain/model/response/res_user_model.dart';
import '../../domain/repository/user_repository.dart';

part 'singin_state.dart';

class SignInCubit extends BaseCubit<BaseState, String> {
  final UserRepository _userRepository;
  final PreferenceRepository _preferenceRepository;

  SignInCubit(this._userRepository, this._preferenceRepository)
      : super(BaseInitState(), "");

  checkLogin() {
    emit(LoadingState());
    var token = _preferenceRepository.getAccessToken();
    if (token.isNotEmpty) {
      emit(SignInState(token: token));
    }
    emit(const ErrorState(errorMessage: ""));
  }

  Future<void> login(String email, String password) async {
    if (isBusy) return;

    await run(() async {
      emit(LoadingState());
      try {
        final response =
            await _userRepository.login(ReqLogin(email:email , password: password));

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
}
