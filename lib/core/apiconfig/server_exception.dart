import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dmpku/core/helpers/encrypt_helper.dart';
import 'package:flutter/cupertino.dart';

class ServerException implements Exception {
  final int code;
  final String message;

  const ServerException({required this.code, required this.message});

  factory ServerException.fromDio({DioException? e, Response? r}) {
    final response = e?.response ?? r;

    final code = response?.statusCode ?? HttpStatus.internalServerError;

    debugPrint('ServerException Code: $code');
    debugPrint('ServerException Response: ${response?.data}');

    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      if (data.containsKey('a')) {
        final a = data['a'] as String;

        debugPrint('ServerException Encrypted Data: $a');
        var enc = Encrypted(a: data["a"] as String);
        var decryptedData = EncryptHelper.decrypt(enc);
        debugPrint("Decrypted Response Data: $decryptedData");

      }
    }

    String? message;
    switch (e?.type) {
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionTimeout:
        message = 'Koneksi Timeout';
        break;
      case DioExceptionType.badCertificate:
        message = 'Sertifikat Tidak Valid';
        break;

      case DioExceptionType.cancel:
        message = 'Permintaan Dibatalkan';
        break;

      case DioExceptionType.badResponse:
        message = 'Respon Tidak Valid';
        break;

      case DioExceptionType.connectionError:
        message = 'Koneksi Error';
        break;
      default:
    }
    if (response != null && response.data is Map<String, dynamic>) {
      final Map<String, dynamic> data = response.data;

      message = data["message"];

      if (message == null || message.isEmpty) {
        final strVal = data.values.whereType<String>();
        message = strVal.firstOrNull;
      }
    }
    return ServerException(code: code, message: message ?? _msgError);
  }
}

const _msgError = 'Terjadi Kesalahan, Silakan Hubungi Customer Service';
