import 'package:shared_preferences/shared_preferences.dart';

class Pocket {
  final asyncPrefs = SharedPreferences.getInstance();

  Future<void> clear() async {
    final prefs = await asyncPrefs;
    await prefs.clear();
  }

  Future<void> setString(String key, String value) async {
    final prefs = await asyncPrefs;
    await prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    final prefs = await asyncPrefs;
    return prefs.getString(key);
  }

  Future<void> setBool(String key, bool value) async {
    final prefs = await asyncPrefs;
    await prefs.setBool(key, value);
  }

  Future<bool?> getBool(String key) async {
    final prefs = await asyncPrefs;
    return prefs.getBool(key);
  }

  Future<void> setInt(String key, int value) async {
    final prefs = await asyncPrefs;
    await prefs.setInt(key, value);
  }

  Future<int?> getInt(String key) async {
    final prefs = await asyncPrefs;
    return prefs.getInt(key);
  }
}