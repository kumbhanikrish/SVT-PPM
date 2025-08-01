import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:svt_ppm/module/auth/model/login_model.dart';

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

  Future setVerificationId(String verificationId) async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString('verificationId', verificationId);
  }

  Future<String> getVerificationId() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    return sharedPreference.getString('verificationId') ?? '';
  }

  // ✅ Save LoginModel as JSON string
  Future<void> setLoginData(LoginModel loginModel) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(loginModel.toJson());
    await sharedPreferences.setString('login_data', jsonString);
    log("LoginModel saved.");
  }

  // ✅ Get LoginModel from storage
  Future<LoginModel> getLoginModel() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final jsonString = sharedPreferences.getString('login_data');
    if (jsonString != null) {
      final jsonMap = jsonDecode(jsonString);
      return LoginModel.fromJson(jsonMap);
    }
    throw Exception("LoginModel not found");
  }
}
