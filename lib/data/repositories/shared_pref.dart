import 'package:shared_preferences/shared_preferences.dart';

class StorageRepository {
  static StorageRepository? _storageUtil;
  static SharedPreferences? _preferences;

  static Future<StorageRepository> getInstance() async {
    if (_storageUtil == null) {
      var secureStorage = StorageRepository._();
      await secureStorage._init();
      _storageUtil = secureStorage;
    }
    return _storageUtil!;
  }

  StorageRepository._();
  Future _init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future putString({
    required String key,
    required String value,
  }) async {
    if (_preferences == null) return null;
    return _preferences!.setString(key, value);
  }

  static Future putBool({
    required String key,
    required bool value,
  }) async {
    if (_preferences == null) return null;
    return _preferences!.setBool(key, value);
  }

  static bool? getBool({required String key}) {
    if (_preferences == null) return null;
    return _preferences!.getBool(key);
  }

  static String? getString({required String key}) {
    if (_preferences == null) return null;
    return _preferences!.getString(key);
  }
}
