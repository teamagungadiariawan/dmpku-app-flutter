import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKeys {
  static const token =
      "bDCMnwWOGQXk8s/IC4IiXuPWDfvwy/Wx4Y3jlAxSRCC8dsWgLdJjc1Ur6qerxA/8";
  static const location =
      "sLm05Q89J2YRKyJNGfzqIxvH/eFHuibnPNAphmos0l+8dsWgLdJjc1Ur6qerxA/8";
  // Tambahkan keys lain di sini
}

class SecureStorageHelper {
  static SecureStorageHelper? _instance;
  static FlutterSecureStorage? _storage;

  SecureStorageHelper._();

  static SecureStorageHelper get instance {
    _instance ??= SecureStorageHelper._();
    return _instance!;
  }

  FlutterSecureStorage get _secureStorage {
    if (_storage != null) return _storage!;

    if (Platform.isAndroid) {
      _storage = const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
      );
    } else if (Platform.isIOS) {
      _storage = const FlutterSecureStorage(
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      );
    } else {
      _storage = const FlutterSecureStorage();
    }
    return _storage!;
  }

  Future<void> write(String key, String value) =>
      _secureStorage.write(key: key, value: value);

  Future<String?> read(String key) => _secureStorage.read(key: key);

  Future<void> delete(String key) => _secureStorage.delete(key: key);

  Future<void> deleteAll() => _secureStorage.deleteAll();

  // Convenience methods
  Future<void> saveToken(String token) => write(StorageKeys.token, token);

  Future<String?> getToken() => read(StorageKeys.token);

  Future<void> clearToken() => delete(StorageKeys.token);
}
