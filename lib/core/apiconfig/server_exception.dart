import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dmpku/core/helpers/encrypt_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/pages/guest/main_page.dart';
import 'package:flutter/cupertino.dart';

class ServerException implements Exception {
  final int code;
  final String message;

  const ServerException({required this.code, required this.message});

  factory ServerException.fromDio({DioException? e, Response? r}) {
    final response = e?.response ?? r;

    final code = response?.statusCode ?? HttpStatus.internalServerError;

    if (response?.data is Map<String, dynamic>) {
      final data = response!.data as Map<String, dynamic>;
      if (data.containsKey('a')) {
        final a = data['a'] as String;
        var enc = Encrypted(a: data["a"] as String);
        var decryptedData = EncryptHelper.decrypt(enc);
        var messageTolowerAndNoSpace =
            (decryptedData['message'] as String?)?.toLowerCase().replaceAll(
              ' ',
              '',
            ) ??
            '';
        if (messageTolowerAndNoSpace == 'tokentidakvalid') {
          // Token tidak valid, hapus token dari penyimpanan
          // SecureStorageHelper.instance.clearToken();
          // debugPrint(
          //   "Token tidak valid. Token telah dihapus dari penyimpanan.",
          // );

          // pushNamedAndRemoveUntil(MainPage.routeName);
        }

        var message = decryptedData['message'] as String? ?? _msgError;
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

        return ServerException(code: code, message: message);
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
