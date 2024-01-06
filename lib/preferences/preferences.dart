import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static SharedPreferences? _preferences;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static get getPreferences => _preferences;
}
