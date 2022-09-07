import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalApp {
  final Box box;
  final SharedPreferences sharedPreferences;

  LocalApp(this.box, this.sharedPreferences);

  Future saveDataToLocal(String key, dynamic value) async {
    await box.put(key, value);
  }

  dynamic getDataFromLocal(String key, {dynamic defaultValue}) {
    if (box.containsKey(key)) {
      return box.get(key) ?? defaultValue;
    }
    return defaultValue;
  }

  Future deleteDataLocal(String key) async {
    if (box.containsKey(key)) {
      await box.delete(key);
    }
  }

  Future saveStringStorage(String key, String value) async {
    await sharedPreferences.setString(key, value);
  }

  String? getStringStorage(String key) {
    return sharedPreferences.getString(key);
  }

  Future saveIntStorage(String key, int value) async {
    await sharedPreferences.setInt(key, value);
  }

  int? getIntStorage(String key) {
    return sharedPreferences.getInt(key);
  }


  Future saveBoolStorage(String key, bool value) async {
    await sharedPreferences.setBool(key, value);
  }

  bool? getBoolStorage(String key) {
    return sharedPreferences.getBool(key);
  }

  dynamic getStorage(String key) {
    return sharedPreferences.get(key);
  }

  Future<bool> removeStorage(String key){
    return sharedPreferences.remove(key);
  }


}
