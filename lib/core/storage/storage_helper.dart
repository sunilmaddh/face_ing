import 'package:get_storage/get_storage.dart';
// For JSON encoding/decoding

class StorageHelper {
  static final _box = GetStorage();

  static Future<void> write(String key, dynamic value) async {
    await _box.write(key, value);
  }

  /// Read data
  static T? read<T>(String key) {
    return _box.read<T>(key);
  }
  // static final _key = encrypt.Key.fromUtf8(
  //   '16byteslongkey!!',
  // ); // Must be 16/24/32 bytes
  // static final _iv = encrypt.IV.fromLength(16);
  // static final _encrypter = encrypt.Encrypter(encrypt.AES(_key));

  // // Encrypt and save (Handles all data types)
  // static void write(String key, dynamic value) {
  //   String jsonValue = jsonEncode(value); // Convert any type to String
  //   final encryptedValue = _encrypter.encrypt(jsonValue, iv: _iv).base64;
  //   box.write(key, encryptedValue);
  // }

  // // Read and decrypt (Handles all data types)
  // static dynamic read(String key) {
  //   final encryptedValue = box.read(key);
  //   if (encryptedValue != null) {
  //     try {
  //       String decryptedJson = _encrypter.decrypt64(encryptedValue, iv: _iv);
  //       return jsonDecode(decryptedJson); // Convert back to original type
  //     } catch (e) {
  //       return null; // Handle potential decryption errors
  //     }
  //   }
  //   return null;
  // }

  /// Remove a specific key from storage
  static void remove(String key) {
    _box.remove(key);
  }

  /// Clear all stored data
  static void clear() {
    StorageHelper.write("userId", "");
    StorageHelper.write("isOnboard", false);
  }
}
