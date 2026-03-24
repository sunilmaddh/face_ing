import 'dart:convert';

class EncryptionService {
  const EncryptionService();

  Object encryptRequest(Object body) {
    final jsonString = jsonEncode(body);
    final encrypted = _encrypt(jsonString);

    return {"payload": encrypted};
  }

  Map<String, dynamic> decryptResponse(Map<String, dynamic> responseBody) {
    final payload = responseBody["payload"];

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
    // TODO: replace with real encryption logic
    // Example: AES / RSA / backend-required method
    return base64Encode(utf8.encode(plainText));
  }

  String _decrypt(String cipherText) {
    // TODO: replace with real decryption logic
    return utf8.decode(base64Decode(cipherText));
  }
}
