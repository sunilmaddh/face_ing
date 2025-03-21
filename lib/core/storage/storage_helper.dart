
import 'package:get_storage/get_storage.dart';

class StorageHelper {
  static final GetStorage _storage = GetStorage();

  /// Save a value to local storage
  static void write(String key, dynamic value) {
    _storage.write(key, value);
  }

  /// Read a value from local storage
  static T? read<T>(String key) {
    return _storage.read<T>(key);
  }

  /// Remove a specific key from storage
  static void remove(String key) {
    _storage.remove(key);
  }

  /// Clear all stored data
  static void clear() {
    _storage.erase();
  }
}
