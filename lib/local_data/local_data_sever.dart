import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class LocalDataSaver {
  Future clearAllData() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    log("All local data cleared successfully.");
    await sharedPreference.clear();
  }

  Future setAuthToken(String authToken) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('authToken', authToken);
  }

  Future<String> getAuthToken() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString('authToken') ?? '';
  }

 
}
