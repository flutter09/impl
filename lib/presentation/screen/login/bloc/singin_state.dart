
import '../../../../base/base_state.dart';

class SignInState extends BaseState{
  final String  token;

  const SignInState({
    this.token = ""
  });
}

class NoSignInState extends BaseState{

}

class SignUpState extends BaseState {
  final bool register;

  const SignUpState({
    this.register = false
  });
}

class ForgotPasswordState extends BaseState {}