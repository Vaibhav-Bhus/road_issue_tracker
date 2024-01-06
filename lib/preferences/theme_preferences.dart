

import 'package:test_aqua_cart/preferences/preferences.dart';

class ThemePreferences {
  static final _preferences = Preferences.getPreferences;

  static const String _darkThemePrefsKey = "darktheme";

  static bool getDarkThemePref() =>
      _preferences?.getBool(_darkThemePrefsKey) ?? false;

  static Future<void> setDarkThemePrefs(bool authPrefs) async =>
      await _preferences?.setBool(_darkThemePrefsKey, authPrefs);
}
