import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String keyTheme = 'theme_mode';

  Future<void> setTheme(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(keyTheme, mode);
  }

  Future<String> getTheme() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(keyTheme) ?? 'light';
  }
}
