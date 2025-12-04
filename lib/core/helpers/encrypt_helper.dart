import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart' as encryptPlug;
import 'package:flutter/cupertino.dart';
import 'package:tuple/tuple.dart';

class Encrypted {
  final String a;

  Encrypted({required this.a});

  factory Encrypted.fromJson(Map<String, dynamic> json) {
    return Encrypted(a: json['a'] as String);
  }

  Map<String, dynamic> toJson() {
    return {'a': a};
  }
}

class ErrorDefault {
  final bool status;
  final String message;

  ErrorDefault({required this.status, required this.message});
}

class EncryptHelper {
  // Konstanta key dan secret
  static const String _keyPart1 = 'r2345t';
  static const String _keyPart2 = 'p89';
  static const String _keyPart3 = 'y2';
  static const String _keyPart4 = '34';
  static const String _keyPart5 = '5e';

  static const String _secretPart1 = 'r232x';
  static const String _secretPart2 = 'k56';
  static const String _secretPart3 = '78';
  static const String _secretPart4 = '9a';
  static const String _secretPart5 = '234';
  static const String _secretPart6 = '5e';

  static String _getKey() {
    return '$_keyPart1$_keyPart2$_keyPart3$_keyPart4$_keyPart5';
  }

  static String _getSecret() {
    return '$_secretPart1$_secretPart2$_secretPart3$_secretPart4$_secretPart5$_secretPart6';
  }

  static String _getCombinedKey() {
    return _getKey() + _getSecret();
  }

  // Enkripsi menggunakan AES dengan salt (seperti crypto_helper)
  static String encryptAes(String plainText) {
    try {
      final passphrase = _getCombinedKey();
      final salt = _genRandomWithNonZero(8);
      var keyndIV = _deriveKeyAndIV(passphrase, salt);
      final key = encryptPlug.Key(keyndIV.item1);
      final iv = encryptPlug.IV(keyndIV.item2);

      final encrypter = encryptPlug.Encrypter(
        encryptPlug.AES(key, mode: encryptPlug.AESMode.cbc, padding: "PKCS7"),
      );
      final encrypted = encrypter.encrypt(plainText, iv: iv);

      Uint8List encryptedBytesWithSalt = Uint8List.fromList(
        _createUint8ListFromString("Salted__") + salt + encrypted.bytes,
      );

      return base64.encode(encryptedBytesWithSalt);
    } catch (e) {
      print('Error encrypting: $e');
      return "";
    }
  }

  // Dekripsi AES dengan salt (seperti crypto_helper)
  static String decryptAes(String encrypted) {
    try {
      final passphrase = _getCombinedKey();
      Uint8List encryptedBytesWithSalt = base64.decode(encrypted);

      Uint8List encryptedBytes = encryptedBytesWithSalt.sublist(
        16,
        encryptedBytesWithSalt.length,
      );
      final salt = encryptedBytesWithSalt.sublist(8, 16);
      var keyndIV = _deriveKeyAndIV(passphrase, salt);
      final key = encryptPlug.Key(keyndIV.item1);
      final iv = encryptPlug.IV(keyndIV.item2);

      final encrypter = encryptPlug.Encrypter(
        encryptPlug.AES(key, mode: encryptPlug.AESMode.cbc, padding: "PKCS7"),
      );
      final decrypted = encrypter.decrypt64(
        base64.encode(encryptedBytes),
        iv: iv,
      );

      return decrypted;
    } catch (e) {
      print('Error decrypting: $e');
      return "";
    }
  }

  // Enkripsi data dengan format Encrypted (tetap dipertahankan untuk backward compatibility)
  static Encrypted encrypt(dynamic data) {
    final jsonData = jsonEncode(data);
    final encryptedString = encryptAes(jsonData);
    return Encrypted(a: encryptedString);
  }

  // Dekripsi data dengan format Encrypted (tetap dipertahankan untuk backward compatibility)
  static dynamic decrypt<T>(Encrypted data) {
    try {
      final decrypted = decryptAes(data.a);

      if (decrypted.isNotEmpty) {
        return jsonDecode(decrypted);
      } else {
        return ErrorDefault(
          status: false,
          message: 'Decryption failed (empty result)',
        );
      }
    } catch (error) {
      print('Decryption error: $error');
      return ErrorDefault(
        status: false,
        message: 'Exception during decryption',
      );
    }
  }

  // Helper functions untuk derive key dan IV (sama seperti crypto_helper)
  static Tuple2<Uint8List, Uint8List> _deriveKeyAndIV(
    String passphrase,
    Uint8List salt,
  ) {
    var password = _createUint8ListFromString(passphrase);
    Uint8List concatenatedHashes = Uint8List(0);
    Uint8List currentHash = Uint8List(0);
    bool enoughBytesForKey = false;
    Uint8List preHash = Uint8List(0);

    while (!enoughBytesForKey) {
      if (currentHash.isNotEmpty) {
        preHash = Uint8List.fromList(currentHash + password + salt);
      } else {
        preHash = Uint8List.fromList(password + salt);
      }

      currentHash = Uint8List.fromList(md5.convert(preHash.toList()).bytes);
      concatenatedHashes = Uint8List.fromList(concatenatedHashes + currentHash);
      if (concatenatedHashes.length >= 48) enoughBytesForKey = true;
    }

    var keyBytes = concatenatedHashes.sublist(0, 32);
    var ivBytes = concatenatedHashes.sublist(32, 48);
    return Tuple2(keyBytes, ivBytes);
  }

  static Uint8List _createUint8ListFromString(String s) {
    var ret = Uint8List(s.length);
    for (var i = 0; i < s.length; i++) {
      ret[i] = s.codeUnitAt(i);
    }
    return ret;
  }

  static Uint8List _genRandomWithNonZero(int seedLength) {
    final random = Random.secure();
    const int randomMax = 245;
    final Uint8List uint8list = Uint8List(seedLength);
    for (int i = 0; i < seedLength; i++) {
      uint8list[i] = random.nextInt(randomMax) + 1;
    }
    return uint8list;
  }

  static String md5Hash({required String input}) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String md5NoAuth({
    required String unixtime,
    required String keterangan,
    required String part,
  }) {
    final signs = unixtime + part + keterangan;
    final str = '${signs}xs${unixtime}xu${part}agung';
    return md5Hash(input: str);
  }

  static String md5SignOtpLogin({
    required String longitude,
    required String uuid,
    required String nohpmember,
  }) {
    final signs = longitude + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}agung';
    debugPrint('otp login sign string: $str');
    return md5Hash(input: str);
  }

  static String md5SignVerifyOtpLogin({
    required String otp,
    required String uuid,
    required String nohpmember,
  }) {
    final signs = otp + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}agung';
    return md5Hash(input: str);
  }

  static String md5SignOtpRegister({
    required String uuid,
    required String nohpmember,
    required String times,
  }) {
    final signs = times + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}a78mn';
    return md5Hash(input: str);
  }

  static String md5SignVerifyOtpRegister({
    required String otp,
    required String uuid,
    required String nohpmember,
  }) {
    final signs = otp + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}a78mn';
    return md5Hash(input: str);
  }

  static String md5SignCekEmail({
    required String email,
    required String uuid,
    required String nohpmember,
  }) {
    final signs = email + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}a78mn';
    print('signs: $signs');
    print('md5SignCekEmail: $str');
    return md5Hash(input: str);
  }

  static String md5SignFinalizeRegister({
    required String times,
    required String token,
    required String nohpmember,
  }) {
    final signs = times + token + nohpmember;
    final str = '${signs}xs${nohpmember}xu${token}a78mn';
    print('signs: $signs');
    print('md5SignFinalizeRegister: $str');
    return md5Hash(input: str);
  }
}