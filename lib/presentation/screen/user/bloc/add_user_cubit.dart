import 'package:chat_application/domain/model/request/req_add_save_user.dart';
import 'package:chat_application/domain/model/request/req_send_otp.dart';
import 'package:chat_application/domain/model/response/save_user_model.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/base_state.dart';
import '../../../../base/result.dart';
import '../../../../domain/repository/save_user_repository.dart';
import '../../../../domain/repository/user_repository.dart';

class AddUserCubit extends BaseCubit<BaseState, String> {
  final SaveUserRepository _saveUserRepository;

  AddUserCubit(this._saveUserRepository) : super(BaseInitState(), "");

  final emailController = TextEditingController();
  final customNameController = TextEditingController();

  List<String> roles = [];
  SaveUserModel? saveUserModel;

  final List<String> options = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4',
    'Option 5',
  ];

  void clearLocalData(){
    print('clear data');
    customNameController.text = "";
    roles.clear();
  }

  Future<void> searchUser() async {
    if (isBusy) return;

    try {
      emit(LoadingState());
      var response = await _saveUserRepository.getSaveUser(ReqSendOtp(email: emailController.text));
      if (response is Success) {
        saveUserModel = (response as Success).data;
        emit(SaveUserState(saveUserModel: (response as Success).data));
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
          userId: saveUserModel!.id,
          userName: customNameController.text,
          name: saveUserModel!.name,
          email: saveUserModel!.email,
          phone: saveUserModel!.phone,
          image: saveUserModel!.image,
          roles: getRoleIndexes(roles) //todo get int array from string array;
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
    print("index : $indexes");
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
