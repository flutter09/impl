import '../../base/base_cubit.dart';
import '../../base/base_state.dart';
import '../../domain/repository/user_repository.dart';

part 'signup_state.dart';

class SignUpCubit extends BaseCubit<BaseState , String> {
  final UserRepository _userRepository;

  SignUpCubit(this._userRepository) : super(BaseInitState(),"");


}
