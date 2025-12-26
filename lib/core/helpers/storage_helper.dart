import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageKeys {
  static const token =
      "bDCMnwWOGQXk8s/IC4IiXuPWDfvwy/Wx4Y3jlAxSRCC8dsWgLdJjc1Ur6qerxA/8";
  static const tokenFcm =
      "bDCMnwWOGQXk8s/IC4IiXuPWDfvwy/Wx4Y3jlAxSRCC8dsWgLdJjc1Ur6qdcmerxA/8";
  static const location =
      "sLm05Q89J2YRKyJNGfzqIxvH/eFHuibnPNAphmos0l+8dsWgLdJjc1Ur6qerxA/8";
  static const signmember =
      "pYM+9wIfFMNpLFxOO1oyxdl+AD6d8/4O3HhEPRyyFSboP2F2HJu4DKWZu/P+EkaF";
  static const refreshToken =
      "1pGJt7if468W8mMir/Wj9/feMG0SF5U4acjtv68c3ywtMnjuAvKzXtaJLNfI3PzP";
  static const kodeMember =
      "ua1iuyCWdtULZ9/qa+v3i5sB8mJfPiQB7ZCaxDOf7EHJfPD9g8hDVQ4Qj0eXAwNz";

  static const wacs = "wacs_key";
  static const channelwa = "channelwa_key";
  static const callcenter = "callcenter_key";
  static const playstore = "playstore_key";

  static const printerName = "printer_name_key";
  static const printerMacAddress = "printer_mac_address_key";

  static const namaKios = "nama_kios_key";
  static const alamatKios = "alamat_kios_key";
  static const footerKios = "footer_kios_key";
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

  // Refresh Token
  Future<void> saveRefreshToken(String refreshToken) =>
      write(StorageKeys.refreshToken, refreshToken);

  Future<String?> getRefreshToken() => read(StorageKeys.refreshToken);

  Future<void> clearRefreshToken() => delete(StorageKeys.refreshToken);

  // Kode Member
  Future<void> saveKodeMember(String kodeMember) =>
      write(StorageKeys.kodeMember, kodeMember);

  Future<String?> getKodeMember() => read(StorageKeys.kodeMember);

  Future<void> clearKodeMember() => delete(StorageKeys.kodeMember);

  // wacs
  Future<void> saveWacs(String wacs) => write(StorageKeys.wacs, wacs);

  Future<String?> getWacs() => read(StorageKeys.wacs);

  Future<void> clearWacs() => delete(StorageKeys.wacs);

  // channelwa
  Future<void> saveChannelWa(String channelwa) =>
      write(StorageKeys.channelwa, channelwa);

  Future<String?> getChannelWa() => read(StorageKeys.channelwa);

  Future<void> clearChannelWa() => delete(StorageKeys.channelwa);

  // callcenter
  Future<void> saveCallCenter(String callcenter) =>
      write(StorageKeys.callcenter, callcenter);

  Future<String?> getCallCenter() => read(StorageKeys.callcenter);

  Future<void> clearCallCenter() => delete(StorageKeys.callcenter);

  // playstore
  Future<void> savePlayStore(String playstore) =>
      write(StorageKeys.playstore, playstore);

  Future<String?> getPlayStore() => read(StorageKeys.playstore);

  Future<void> clearPlayStore() => delete(StorageKeys.playstore);

  // printerName
  Future<void> savePrinterName(String printerName) =>
      write(StorageKeys.printerName, printerName);

  Future<String?> getPrinterName() => read(StorageKeys.printerName);

  Future<void> clearPrinterName() => delete(StorageKeys.printerName);

  // printerMacAddress
  Future<void> savePrinterMacAddress(String printerMacAddress) =>
      write(StorageKeys.printerMacAddress, printerMacAddress);

  Future<String?> getPrinterMacAddress() => read(StorageKeys.printerMacAddress);

  Future<void> clearPrinterMacAddress() =>
      delete(StorageKeys.printerMacAddress);

  // namaKios
  Future<void> saveNamaKios(String namaKios) =>
      write(StorageKeys.namaKios, namaKios);

  Future<String?> getNamaKios() => read(StorageKeys.namaKios);

  Future<void> clearNamaKios() => delete(StorageKeys.namaKios);

  // alamatKios
  Future<void> saveAlamatKios(String alamatKios) =>
      write(StorageKeys.alamatKios, alamatKios);

  Future<String?> getAlamatKios() => read(StorageKeys.alamatKios);

  Future<void> clearAlamatKios() => delete(StorageKeys.alamatKios);

  // footerKios
  Future<void> saveFooterKios(String footerKios) =>
      write(StorageKeys.footerKios, footerKios);

  Future<String?> getFooterKios() => read(StorageKeys.footerKios);

  Future<void> clearFooterKios() => delete(StorageKeys.footerKios);
}
