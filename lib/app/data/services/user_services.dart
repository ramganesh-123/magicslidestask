import 'package:get/get.dart';
import 'package:magicslides_app/app/core/config/app_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService extends GetxService {
  late SharedPreferences _prefs;

  Future<StorageService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> saveThemeMode(bool isDark) async {
    await _prefs.setBool(AppConstants.themeKey, isDark);
  }

  bool getThemeMode() {
    return _prefs.getBool(AppConstants.themeKey) ?? false;
  }

  Future<void> saveUserEmail(String email) async {
    await _prefs.setString('user_email', email);
  }

  String? getUserEmail() {
    return _prefs.getString('user_email');
  }

  Future<void> clearUserData() async {
    await _prefs.remove('user_email');
  }

  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> remove(String key) async {
    await _prefs.remove(key);
  }

  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
