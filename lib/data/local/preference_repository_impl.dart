
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
  Future<String> getLanguage() async {
    return getStringF(PreferenceConstant.language);
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
  Future<String> getAccessTokenF() async {
    return getStringF(PreferenceConstant.token);
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
  Future<String> getRefreshToken() async {
    return getStringF(PreferenceConstant.refreshToken);
  }

  @override
  setRefreshToken(String value) {
    setString(PreferenceConstant.refreshToken, value);
  }

  @override
  Future<bool> getOnBoardingStatus() async {
    return getBoolF(PreferenceConstant.onBoardingFlow);
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
  Future<String> getLoginData() async {
    return getStringF(PreferenceConstant.loginData);
  }

  @override
  setLoginData(String data) {
    setString(PreferenceConstant.loginData, data);
  }

  @override
  String getUserId() {
    return getString(PreferenceConstant.userId);
  }

  @override
  Future<String> getUserIdF() async {
    return getStringF(PreferenceConstant.userId);
  }

  @override
  setUserId(String value) {
    setString(PreferenceConstant.userId, value);
  }

  @override
  String getUserName() {
    return getString(PreferenceConstant.userName);
  }

  @override
  Future<String> getUserNameF() async {
    return getStringF(PreferenceConstant.userName);
  }

  @override
  setUserName(String value) {
    setString(PreferenceConstant.userName, value);
  }
}
