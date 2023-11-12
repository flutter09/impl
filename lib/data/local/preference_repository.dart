import '../../domain/model/response/res_user_model.dart';

abstract class PreferenceRepository {
  initPreference();

  Future<String> getLanguage();

  setLanguage(String value);

  setAccessToken(String value);

  Future<String> getAccessTokenF();

  String getAccessToken();

  setRefreshToken(String value);

  Future<String> getRefreshToken();

  setOnBoardingStatus(bool value);

  Future<bool> getOnBoardingStatus();

  clearPreference();

  setLoginData(String data);
  Future<String> getLoginData();

  setUserId(String value);
  Future<String> getUserIdF();
  String getUserId();


  setUserName(String value);
  Future<String> getUserNameF();
  String getUserName();

  setUserMail(String value);
  Future<String> getUserMailF();
  String getUserMail();

  setUserPhone(String value);
  Future<String> getUserPhoneF();
  String getUserPhone();

  setUser(ResUserModel user);
  Future<ResUserModel> getUserF();
  ResUserModel getUser();

}
