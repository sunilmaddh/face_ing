import 'dart:ffi';

import 'package:shared_preferences/shared_preferences.dart';

class IndoSharedPreference {
  SharedPreferences? _preferences;
  IndoSharedPreference._internal();

  static final IndoSharedPreference _instance =
      IndoSharedPreference._internal();

  static IndoSharedPreference get instance => _instance;
  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  Future<void> saveUserId(String uiserId) async {
    _preferences?.setString("user_id", uiserId);
  }

  Future<String> getUserId() async {
    return _preferences?.getString("user_id") ?? "";
  }

  Future<void> saveWalkScreen(bool walkScreen) async {
    _preferences?.setBool("walk_screen", walkScreen);
  }

  Future<bool> getWalkScreen() async {
    return _preferences?.getBool("walk_screen") ?? false;
  }

  Future<void> saveOnBoard(String onBoard) async {
    _preferences?.setString("on_board", onBoard);
  }

  Future<String> getOnBoard() async {
    return _preferences?.getString("on_board") ?? "";
  }

  Future<void> saveAccessToken(String accessToken) async {
    _preferences?.setString("access_token", accessToken);
  }

  Future<String> getAccessToken() async {
    return _preferences?.getString("access_token") ?? "";
  }

  Future<void> saveRefereshToken(String refereshToken) async {
    _preferences?.setString("referesh_token", refereshToken);
  }

  Future<String> getRefereshToken() async {
    return _preferences?.getString("referesh_token") ?? "";
  }
}
