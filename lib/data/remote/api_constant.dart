class DioApiConstants {
  static const String baseUrl = "http://13.200.27.186/v1/";

  static const String userLogin = "user/user_login";
  static const String userRegister = "user/user_register";
  static const String updateUser = "user/update_user";
  static const String deleteUser = "user/delete_user";
  static const String forgotPassword = "user/forgot_password";
  static const String checkOtp = "user/check_otp";
  static const String sendOtp = "user/send_otp";
  static const String getUserDetails = "user/get_user";

  //project details
  static const String projectRegister = "user/project_register";
  static const String projectUpdate = "user/project_update";
  static const String projectDetails = "user/project_details";
  static const String projectAddMembers = "user/project_add_member";
  static const String projectList = "user/project_list";

  //User Save
  static const String getOtherUserDetail= "user/get_other_user_details";
  static const String addUserSaveList= "user/add_userSave_list";
  static const String editUserSaveList = "user/edit_userSave_list";

  //group
  static const String groupRegister ="user/group_register";
  static const String groupUpdate ="user/group_update";
  static const String groupAddNumber ="user/group_add_member";
  static const String groupList ="user/group_list";
  static const String groupDetails ="user/group_details";


  static const String uploadFile = "upload_file";

}

/*
class DioApiConstants {
  static const String baseUrl = "http://13.200.27.186/";

  static const String userLogin = "user_login";
  static const String userRegister = "user_register";
  static const String forgotPassword = "forgot_password";
  static const String checkOtp = "check_otp";
  static const String sendOtp = "send_otp";
}*/
