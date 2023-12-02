import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Singleton()
class SharedPreferencesHelper {
  static setData(String key, value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint(
        "Shared Preferences Helper: setData with key: $key & value: $value");
    switch (value.runtimeType) {
      case String:
        prefs.setString(key, value);
        break;
      case int:
        prefs.setInt(key, value);
        break;
      case double:
        prefs.setDouble(key, value);
        break;
      case bool:
        prefs.setBool(key, value);
        break;
      case List:
        prefs.setStringList(key, value);
        break;
      default:
        debugPrint("Shared Preferences Helper: There\'s No Type Matched!");
        return null;
    }
  }

  static getData(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    debugPrint("Shared Preferences Helper: getData with key: $key");
    return prefs.get(key);
  }
}
