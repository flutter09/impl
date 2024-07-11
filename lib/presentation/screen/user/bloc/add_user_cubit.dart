import 'package:chat_application/data/local/preference_constant.dart';
import 'package:chat_application/data/local/preference_utils.dart';
import 'package:chat_application/domain/model/request/req_add_save_user.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/domain/model/response/search_user_model.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/base_state.dart';
import '../../../../base/result.dart';
import '../../../../domain/repository/save_user_repository.dart';

class AddUserCubit extends BaseCubit<BaseState, String> {
  final SaveUserRepository _saveUserRepository;

  AddUserCubit(this._saveUserRepository) : super(BaseInitState(), "");

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final clientNameController = TextEditingController();
  final uniqueNameController = TextEditingController();
  final phoneController = TextEditingController();
  final technologyController = TextEditingController();

  List<String> roles = [];
  SearchUserData? saveUserModel;

  final List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  void clearLocalData(){
    usernameController.text = "";
    roles.clear();
  }

  Future<void> searchUser() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response = await _saveUserRepository.getSaveUser(ReqSearchUser(uniqueName: emailController.text));
      if (response is Success) {
        saveUserModel = (response as Success).data;
        emit(SaveUserState());
      } else {
        emit(ErrorState(
            errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> addSaveUser() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var reqAddSaveUser = ReqAddSaveUser(
        userIdOfAddedUser: saveUserModel?.id ?? "",
        userSaveId: getString(PreferenceConstant.userId),
        firstName: usernameController.text,
        lastName: "",
        roles: [],
        defaultName: usernameController.text,
        email: emailController.text,
        phone: phoneController.text,
        image: "",
        address: "",
        country: "",
        city: "",
        dateOfBirth: null,
      );
      var response = await _saveUserRepository.addSaveUser(reqAddSaveUser);

      if (response is Success) {
        emit(AddSaveUserState(message: (response as Success).data));
      } else {
        emit(ErrorState(errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
    clearLocalData();
  }

  Future<void> updateSaveUser(ReqAddSaveUser reqAddSaveUser) async {
    if (isBusy) return;

    try {
      emit(LoadingState());

      var response = await _saveUserRepository.editSaveUser(reqAddSaveUser);

      if (response is Success) {
        emit(UpdateSaveUserState(message: (response as Success).data));
      } else {
        emit(ErrorState(errorMessage: (response as Error).errorResponse.errorMessage));
      }
    } catch (e) {
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  List<int> getRoleIndexes(List<String> roles){
    List<int> indexes = [];
    options.forEachIndexed((index,value) => {
      if(roles.contains(value)){
        indexes.add(index)
      }
    });
    return indexes;
  }

  List<String> getRoleFromIndexes(List<int> indexes){
    List<String> result = [];
    options.forEachIndexed((index,value) => {
      if(indexes.contains(index)){
        result.add(value)
      }
    });
    return result;
  }
}
