
import 'package:chat_application/data/local/preference_constant.dart';
import 'package:chat_application/data/local/preference_repository.dart';
import 'package:chat_application/data/local/preference_utils.dart';

class PreferenceRepositoryImpl implements PreferenceRepository {
  PreferenceRepositoryImpl._();

  static final PreferenceRepositoryImpl preferenceRepositoryImpl =
      PreferenceRepositoryImpl._();

  factory PreferenceRepositoryImpl() {
    return preferenceRepositoryImpl;
  }

  @override
  String getLanguage() {
    return getString(PreferenceConstant.language);
  }

  @override
  setLanguage(String value) {
    setString(PreferenceConstant.language, value);
  }

  @override
  Future initPreference() async {
    await initSharedPreferences();
  }

  @override
  String getAccessToken() {
    return getString(PreferenceConstant.token);
  }

  @override
  setAccessToken(String value) {
    setString(PreferenceConstant.token, value);
  }

  @override
  String getRefreshToken() {
    return getString(PreferenceConstant.refreshToken);
  }

  @override
  setRefreshToken(String value) {
    setString(PreferenceConstant.refreshToken, value);
  }

  @override
  bool getOnBoardingStatus() {
    return getBool(PreferenceConstant.onBoardingFlow);
  }

  @override
  setOnBoardingStatus(bool value) {
    setBool(PreferenceConstant.onBoardingFlow, value);
  }

  @override
  clearPreference() {
   clear();
   setBool(PreferenceConstant.onBoardingFlow, true);
  }

  @override
  String getLoginData() {
    return getString(PreferenceConstant.loginData);
  }

  @override
  setLoginData(String data) {
    setString(PreferenceConstant.loginData, data);
  }
}
