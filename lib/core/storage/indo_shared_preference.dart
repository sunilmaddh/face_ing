import 'package:shared_preferences/shared_preferences.dart';

class IndoSharedPreference {
  SharedPreferences? _preferences;

  IndoSharedPreference._internal();

  static final IndoSharedPreference _instance =
      IndoSharedPreference._internal();

  static IndoSharedPreference get instance => _instance;

  /// Call this before using the instance to ensure prefs are ready
  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  void _checkInit() {
    if (_preferences == null) {
      throw Exception(
        "SharedPreferences not initialized. Call IndoSharedPreference.instance.init() first.",
      );
    }
  }

  Future<void> saveUserId(String userId) async {
    _checkInit();
    await _preferences!.setString("user_id", userId);
  }

  Future<String> getUserId() async {
    _checkInit();
    return _preferences!.getString("user_id") ?? "";
  }

  Future<void> saveWalkScreen(bool walkScreen) async {
    _checkInit();
    await _preferences!.setBool("walk_screen", walkScreen);
  }

  Future<bool> getWalkScreen() async {
    _checkInit();
    return _preferences!.getBool("walk_screen") ?? false;
  }

  Future<void> saveOnBoard(String onBoard) async {
    _checkInit();
    await _preferences!.setString("on_board", onBoard);
  }

  Future<String> getOnBoard() async {
    _checkInit();
    return _preferences!.getString("on_board") ?? "";
  }

  Future<void> saveAccessToken(String accessToken) async {
    _checkInit();
    await _preferences!.setString("access_token", accessToken);
  }

  Future<String> getAccessToken() async {
    _checkInit();
    return _preferences!.getString("access_token") ?? "";
  }

  Future<void> saveUserName(String userName) async {
    _checkInit();
    await _preferences!.setString("user_name", userName);
  }

  Future<String> getUserName() async {
    _checkInit();
    return _preferences!.getString("user_name") ?? "";
  }

  Future<void> saveUserEmail(String userName) async {
    _checkInit();
    await _preferences!.setString("user_email", userName);
  }

  Future<String> getUserEmail() async {
    _checkInit();
    return _preferences!.getString("user_email") ?? "";
  }

  Future<void> saveUserImage(String userName) async {
    _checkInit();
    await _preferences!.setString("user_image", userName);
  }

  Future<String> getUserImage() async {
    _checkInit();
    return _preferences!.getString("user_image") ?? "";
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    _checkInit();
    await _preferences!.setString("refresh_token", refreshToken);
  }

  Future<String> getRefreshToken() async {
    _checkInit();
    return _preferences!.getString("refresh_token") ?? "";
  }

  Future<void> saveHeight(String height) async {
    _checkInit();
    await _preferences!.setString("height", height);
  }

  Future<String> getHeight() async {
    _checkInit();
    return _preferences!.getString("height") ?? "";
  }

  Future<void> saveWeight(String weight) async {
    _checkInit();
    await _preferences!.setString("weight", weight);
  }

  Future<String> getWeight() async {
    _checkInit();
    return _preferences!.getString("weight") ?? "";
  }

  Future<void> saveAge(String age) async {
    _checkInit();
    await _preferences!.setString("age", age);
  }

  Future<String> getAge() async {
    _checkInit();
    return _preferences!.getString("age") ?? "";
  }

  Future<void> saveGenderType(String genderType) async {
    _checkInit();
    await _preferences!.setString("gender_type", genderType);
  }

  Future<String> getGenderType() async {
    _checkInit();
    return _preferences!.getString("gender_type") ?? "";
  }

  Future<void> saveSmokerType(String genderType) async {
    _checkInit();
    await _preferences!.setString("smoker_type", genderType);
  }

  Future<String> getSmokerType() async {
    _checkInit();
    return _preferences!.getString("smoker_type") ?? "";
  }

  Future<void> saveHistoryType(bool genderType) async {
    _checkInit();
    await _preferences!.setBool("history_type", genderType);
  }

  Future<bool> getHistoryType() async {
    _checkInit();
    return _preferences!.getBool("history_type") ?? false;
  }
}
