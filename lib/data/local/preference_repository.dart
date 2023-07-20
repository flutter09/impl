abstract class PreferenceRepository {
  initPreference();

  Future<String> getLanguage();

  setLanguage(String value);

  setAccessToken(String value);

  Future<String> getAccessToken();

  setRefreshToken(String value);

  Future<String> getRefreshToken();

  setOnBoardingStatus(bool value);

  Future<bool> getOnBoardingStatus();

  clearPreference();

  setLoginData(String data);
  Future<String> getLoginData();
}
