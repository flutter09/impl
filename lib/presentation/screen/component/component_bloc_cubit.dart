import 'package:bloc/bloc.dart';
import 'package:chat_application/base/base_cubit.dart';
import 'package:chat_application/base/base_state.dart';
import 'package:meta/meta.dart';

import '../../../data/local/preference_repository.dart';

class ComponentBlocCubit extends BaseCubit<BaseState , String>{
final PreferenceRepository _preferenceRepository;
  ComponentBlocCubit(this._preferenceRepository) : super(BaseInitState() , "");

  var userName = "";
  var userMail = "";

  void getDrawerDetails () async {
    userName = _preferenceRepository.getUserName();
    userMail = _preferenceRepository.getUserMail();
  }

}
