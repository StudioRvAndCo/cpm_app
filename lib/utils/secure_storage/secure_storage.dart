import 'package:cpm/utils/secure_storage/secure_storage_key.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static final SecureStorage _instance = SecureStorage._internal();
  late final FlutterSecureStorage _secureStorage;

  factory SecureStorage() {
    return _instance;
  }

  SecureStorage._internal() {
    _secureStorage = const FlutterSecureStorage();
  }

  Future<String?> read(SecureStorageKey secureStorageKey) async {
    return _secureStorage.read(
      key: secureStorageKey.name,
      aOptions: _getAndroidOptions(),
    );
  }

  Future<void> write(SecureStorageKey secureStorageKey, String value) async {
    await _secureStorage.write(
      key: secureStorageKey.name,
      value: value,
      aOptions: _getAndroidOptions(),
    );
  }

  AndroidOptions _getAndroidOptions() {
    return const AndroidOptions(
      encryptedSharedPreferences: true,
    );
  }
}
