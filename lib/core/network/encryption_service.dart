import 'dart:convert';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:ntt_data/core/constants/api_constants.dart';

class EncryptionService {
  const EncryptionService();

  static final encrypt.Key _key = encrypt.Key.fromUtf8(
    '32characterslongsecretkey!!!!',
  );

  static final encrypt.IV _iv = encrypt.IV.fromUtf8('16charactersiv!!');

  static final encrypt.Encrypter _encrypter = encrypt.Encrypter(
    encrypt.AES(_key, mode: encrypt.AESMode.cbc),
  );

  Object encryptRequest(Object body) {
    final jsonString = jsonEncode(body);
    final encrypted = _encrypt(jsonString);

    return {ApiConstants.payload: encrypted};
  }

  Map<String, dynamic> decryptResponse(Map<String, dynamic> responseBody) {
    final payload = responseBody[ApiConstants.payload];

    if (payload is! String || payload.isEmpty) {
      return responseBody;
    }

    final decrypted = _decrypt(payload);
    final decoded = jsonDecode(decrypted);

    if (decoded is Map<String, dynamic>) {
      return decoded;
    }

    throw Exception("Invalid decrypted response format");
  }

  String _encrypt(String plainText) {
    final encrypted = _encrypter.encrypt(plainText, iv: _iv);
    return encrypted.base64;
  }

  String _decrypt(String cipherText) {
    return _encrypter.decrypt64(cipherText, iv: _iv);
  }
}
