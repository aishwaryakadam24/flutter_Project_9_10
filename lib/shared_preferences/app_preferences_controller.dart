import 'package:shared_preferences/shared_preferences.dart';

class AppSettingsPreferances{
  late SharedPreferences _sharedPreferences;

  static final  AppSettingsPreferances _instance = AppSettingsPreferances._internal();
  AppSettingsPreferances._internal();

  factory AppSettingsPreferances(){
    return _instance;
  }
  Future<void>initPreferances()async{
    _sharedPreferences =await SharedPreferences.getInstance();
  }

  // Language logic removed, always English
  String get langCode => 'en';

  // to remove the language and go to local language
  Future<void> removeLanguage({required String language})async {
    await _sharedPreferences.remove(language);
  }

}

