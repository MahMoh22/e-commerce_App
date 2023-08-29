import 'package:e_commerce_app/presentation/resources/languge_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String PREFS_KEY_LANG = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGEDIN = "PREFS_KEY_IS_USER_LOGGEDIN";

class AppPreferences {
  SharedPreferences _preferences;
  AppPreferences(this._preferences);

  Future<String> getAppLang() async {
    String? language = _preferences.getString(PREFS_KEY_LANG);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue();
    }
  }

  Future<void> setOnboardingScreenViewed() async {
    _preferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnboardingScreenViewed() async {
    return _preferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ?? false;
  }

  Future<void> setuserLoggedin() async {
    _preferences.setBool(PREFS_KEY_IS_USER_LOGGEDIN, true);
  }

  Future<bool> isuserLoggedin() async {
    return _preferences.getBool(PREFS_KEY_IS_USER_LOGGEDIN) ?? false;
  }
}
