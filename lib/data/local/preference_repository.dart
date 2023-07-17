abstract class PreferenceRepository {
  initPreference();

  String getLanguage();

  setLanguage(String value);

  setAccessToken(String value);

  String getAccessToken();

  setRefreshToken(String value);

  String getRefreshToken();

  setOnBoardingStatus(bool value);

  bool getOnBoardingStatus();

  clearPreference();

  setLoginData(String data);
  String getLoginData();
}
