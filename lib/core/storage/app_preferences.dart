import 'package:ntt_data/core/constants/app_logs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ntt_data/core/constants/storage_keys.dart';

class AppPreferences {
  AppPreferences._internal();
  static final AppPreferences instance = AppPreferences._internal();

  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences ??= await SharedPreferences.getInstance();
  }

  void _checkInit() {
    if (_preferences == null) {
      throw Exception(AppLogs.throwException);
    }
  }

  Future<void> setString(String key, String value) async {
    _checkInit();
    await _preferences!.setString(key, value);
  }

  String getString(String key, {String defaultValue = ''}) {
    _checkInit();
    return _preferences!.getString(key) ?? defaultValue;
  }

  Future<void> setBool(String key, bool value) async {
    _checkInit();
    await _preferences!.setBool(key, value);
  }

  bool getBool(String key, {bool defaultValue = false}) {
    _checkInit();
    return _preferences!.getBool(key) ?? defaultValue;
  }

  Future<void> saveUserId(String value) => setString(StorageKeys.userId, value);
  String getUserId() => getString(StorageKeys.userId);

  Future<void> saveWalkScreen(bool value) =>
      setBool(StorageKeys.walkScreen, value);
  bool getWalkScreen() => getBool(StorageKeys.walkScreen);

  Future<void> saveOnBoard(String value) =>
      setString(StorageKeys.onBoard, value);
  String getOnBoard() => getString(StorageKeys.onBoard);

  Future<void> saveUserName(String value) =>
      setString(StorageKeys.userName, value);
  String getUserName() => getString(StorageKeys.userName);

  Future<void> saveUserEmail(String value) =>
      setString(StorageKeys.userEmail, value);
  String getUserEmail() => getString(StorageKeys.userEmail);

  Future<void> saveUserImage(String value) =>
      setString(StorageKeys.userImage, value);
  String getUserImage() => getString(StorageKeys.userImage);

  Future<void> saveHeight(String value) => setString(StorageKeys.height, value);
  String getHeight() => getString(StorageKeys.height);

  Future<void> saveWeight(String value) => setString(StorageKeys.weight, value);
  String getWeight() => getString(StorageKeys.weight);

  Future<void> saveAge(String value) => setString(StorageKeys.age, value);
  String getAge() => getString(StorageKeys.age);

  Future<void> saveGenderType(String value) =>
      setString(StorageKeys.genderType, value);
  String getGenderType() => getString(StorageKeys.genderType);

  Future<void> saveSmokerType(String value) =>
      setString(StorageKeys.smokerType, value);
  String getSmokerType() => getString(StorageKeys.smokerType);

  Future<void> saveEmailId(String value) =>
      setString(StorageKeys.emailId, value);
  String getEmailId() => getString(StorageKeys.emailId);

  Future<void> saveHistoryType(bool value) =>
      setBool(StorageKeys.historyType, value);
  bool getHistoryType() => getBool(StorageKeys.historyType);

  Future<void> clearAll() async {
    _checkInit();
    await _preferences!.clear();
  }
}
