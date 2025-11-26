import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';

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
  static String _getKey() {
    const anu = 'r2345t';
    const minul = 'p89';
    const jaka = 'y2';
    const maria = '34';
    const zahra = '5e';
    return '$anu$minul$jaka$maria$zahra';
  }

  static String _getSecret() {
    const aku = 'r232x';
    const bisa = 'k56';
    const merasa = '78';
    const sayang = '9a';
    const kamu = '234';
    const test = '5e';
    return '$aku$bisa$merasa$sayang$kamu$test';
  }

  static Encrypted encrypt(dynamic data) {
    final key = _getKey();
    final secret = _getSecret();
    final combinedKey = key + secret;

    final encrypter = Encrypter(AES(
      Key.fromUtf8(combinedKey.padRight(32, '0').substring(0, 32)),
      mode: AESMode.cbc,
    ));

    final iv = IV.fromLength(16);
    final jsonData = jsonEncode(data);
    final encrypted = encrypter.encrypt(jsonData, iv: iv);

    return Encrypted(a: encrypted.base64);
  }

  static dynamic decrypt<T>(Encrypted data) {
    try {
      final key = _getKey();
      final secret = _getSecret();
      final combinedKey = key + secret;

      final encrypter = Encrypter(AES(
        Key.fromUtf8(combinedKey.padRight(32, '0').substring(0, 32)),
        mode: AESMode.cbc,
      ));

      final iv = IV.fromLength(16);
      final decrypted = encrypter.decrypt64(data.a, iv: iv);

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

  static String md5Hash(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  static String md5NoAuth(String unixtime, String keterangan, String part) {
    final signs = unixtime + part + keterangan;
    final str = '${signs}xs${unixtime}xu${part}agung';
    return md5Hash(str);
  }

  static String md5SignOtpLogin(
      String longitude, String uuid, String nohpmember) {
    final signs = longitude + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}agung';
    return md5Hash(str);
  }

  static String md5SignVerifyOtpLogin(
      String otp, String uuid, String nohpmember) {
    final signs = otp + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}agung';
    return md5Hash(str);
  }

  static String md5SignOtpRegister(
      String uuid, String nohpmember, String times) {
    final signs = times + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}a78mn';
    return md5Hash(str);
  }

  static String md5SignVerifyOtpRegister(
      String otp, String uuid, String nohpmember) {
    final signs = otp + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}a78mn';
    return md5Hash(str);
  }

  static String md5SignCekEmail(
      String email, String uuid, String nohpmember) {
    final signs = email + uuid + nohpmember;
    final str = '${signs}xs${nohpmember}xu${uuid}a78mn';
    print('signs: $signs');
    print('md5SignCekEmail: $str');
    return md5Hash(str);
  }

  static String md5SignFinalizeRegister(
      String times, String token, String nohpmember) {
    final signs = times + token + nohpmember;
    final str = '${signs}xs${nohpmember}xu${token}a78mn';
    print('signs: $signs');
    print('md5SignFinalizeRegister: $str');
    return md5Hash(str);
  }
}