import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class SharePreferencesClass {
  // SharedPreferences preferences=SharedPreferences as SharedPreferences;
  storeStringData(var key, var value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, value);
    await preferences.reload();
  }

  Future<String?> getStringData(var key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return preferences.getString(key);
  }

  /// used for int data type
  storeIntData(var key, var value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setInt(key, value);
    await preferences.reload();
  }

  Future<int> getIntData(var key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return preferences.getInt(key) ?? 0;
  }

  /// used for int data type

  /// used bool data type
  storeBoolData(var key, var value) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(key, value);
    await preferences.reload();
  }

  getBoolData(var key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.reload();
    return preferences.getBool(key);
  }

  /// used for bool data type

  removeData(var key) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.remove(key);
    await preferences.reload();
    log("current Key in SharedPreference: ${preferences.remove(key)}");
  }

  /// used for object data type
  Future<void> storeObjectData(String key, var object) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, json.encode(object));
    await preferences.reload();
    log("data has been stored in sharedPreferences : ${jsonDecode(preferences.getString(key).toString())}");
  }

  /// store and get List of data
  Future<void> storeListData(String key, List<String> list) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setStringList(key, list).then((value) {
      log("data has been stored in sharedPreferences in a List : ${value}");
    }).catchError((e) {
      log("Error while data  stored in sharedPreferences in a List : $e");
    });
    await preferences.reload();
  }

  Future<List<String>> getListData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    List<String> list = await preferences.getStringList(key) ?? [];
    await preferences.reload();
    return list;
  }

  /// save google user object
  Future<void> saveGoogleUserInfo(String key, var object) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString(key, json.encode(object));
    await preferences.reload();
    log("data has been stored: ${json.decode(preferences.getString(key).toString())}");
  }

  Future<dynamic> getObjectData(String key) async {
    final preferences = await SharedPreferences.getInstance();
    var user = preferences.getString(key);
    log("current user in sharedPreference: $user");
    await preferences.reload();
    final userData = jsonDecode(user.toString());
    return userData;
  }
}
