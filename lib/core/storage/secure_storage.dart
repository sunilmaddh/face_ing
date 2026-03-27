import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ntt_data/core/constants/api_constants.dart';

class SecureStorageService {
  SecureStorageService._();
  static final SecureStorageService instance = SecureStorageService._();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  static const String _accessTokenKey = ApiConstants.accessKey;
  static const String _refreshTokenKey = ApiConstants.refreshKey;
  Future<void> saveAccessToken(String token) async {
    await _storage.write(key: _accessTokenKey, value: token);
  }

  Future<String> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey) ?? '';
  }

  Future<void> saveRefreshToken(String token) async {
    await _storage.write(key: _refreshTokenKey, value: token);
  }

  Future<String> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey) ?? '';
  }

  Future<void> clearTokens() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }

  Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}
