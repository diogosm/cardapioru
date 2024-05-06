import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {

  static const tokenKey = 'token';

  late SharedPreferences sharedPreferences;

  Future<String> getToken() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(tokenKey) ?? "";
    final data = jsonDecode(jsonString);
    return data["token"];
  }

  Future<String> getData() async {
    sharedPreferences = await SharedPreferences.getInstance();
    final String jsonString = sharedPreferences.getString(tokenKey) ?? "";
    final data = jsonDecode(jsonString);
    return data["data"];
  }

  Future<void> saveToken(String token, String? date) async {
    sharedPreferences = await SharedPreferences.getInstance();
    final data = {'token': token, 'data': date ?? DateTime.now().toString()};
    final jsonString = jsonEncode(data);
    sharedPreferences.setString(tokenKey, jsonString);
  }

}