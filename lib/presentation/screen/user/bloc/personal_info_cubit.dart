import 'package:chat_application/domain/model/request/req_user_detail.dart';
import 'package:chat_application/domain/model/response/res_user_model.dart';
import 'package:flutter/material.dart';
import 'package:chat_application/base/result.dart';
import 'package:chat_application/presentation/screen/user/bloc/user_state.dart';

import '../../../../base/base_cubit.dart';
import '../../../../base/base_state.dart';
import '../../../../data/local/preference_repository.dart';
import '../../../../domain/repository/user_repository.dart';

class PersonalInfoCubit extends BaseCubit<BaseState , String>{

  final UserRepository _userRepository;
  final PreferenceRepository _preferenceRepository;

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController technologyController = TextEditingController();

  ResUserModel resUserModel = ResUserModel();

  PersonalInfoCubit(this._userRepository, this._preferenceRepository) : super(BaseInitState(), "");

  Future<void> getUserDetails() async {
    if (isBusy) return;

    try{
      emit(LoadingState());
      var response = await _userRepository.getUserDetails();
      if(response is Success){
        setData((response as Success).data);
        setController();
        emit(UserState(resUserModel: (response as Success).data));
      }else{
        emit(ErrorState(errorMessage: (response as Error).errorResponse.errorMessage));
      }
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> updateUserDetails() async {
    if (isBusy) return;

    try{
      emit(LoadingState());
      var response = await _userRepository.updateUserDetails(
          ReqUserDetail(name: nameController.text, email: emailController.text, phone: phoneNumberController.text, password: ""),
          null
      );
      if(response is Success){
        setUserModel();
        emit(UserUpdateState(message: (response as Success).data));
      }else{
        emit(ErrorState(errorMessage: (response as Error).errorResponse.errorMessage));
      }
    }catch(e){
      emit(ErrorState(errorMessage: e.toString()));
    }
  }

  void setData(ResUserModel model){
    resUserModel = model;
  }

  void setController() {
    // print("name : ${resUserModel.name ?? "no value"}");
    // fullNameController.text = resUserModel.name ?? "";
    nameController.text = resUserModel.uniqueName ?? "";
    emailController.text = resUserModel.email ?? "";
    phoneNumberController.text = resUserModel.phone ?? "";
    dobController.text = resUserModel.dateOfBirth ?? "";
    addressController.text = resUserModel.address ?? "";
    countryController.text = resUserModel.country ?? "";
    cityController.text = resUserModel.city ?? "";
    // technologyController.text = resUserModel.technology ?? "";
  }

  void setUserModel(){
    // resUserModel.name = fullNameController.text;
    resUserModel.uniqueName = nameController.text;
    resUserModel.email = emailController.text;
    resUserModel.phone = phoneNumberController.text;
    resUserModel.dateOfBirth = dobController.text;
    resUserModel.address = addressController.text;
    resUserModel.country = countryController.text;
    resUserModel.city = cityController.text;
    // resUserModel.technology = technologyController.text;
  }

}