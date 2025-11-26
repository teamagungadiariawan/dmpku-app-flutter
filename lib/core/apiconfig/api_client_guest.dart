import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dmpku/core/helpers/connection_helper.dart';
import 'package:flutter/cupertino.dart';

String _base() {
  const sil = 'https://';
  const ros = 'debug';
  const mau = '.';
  const sher = 'mit';
  const fir = 'ra';
  const rah = 'kon';
  const bung = 'ter.';
  const yun = 'com';
  final bsrl = [sil, ros, mau, sher, fir, rah, bung, yun].join('');
  return bsrl;
}

String _baseReg() {
  const sil = 'https://';
  const ros = 'regional';
  const mau = '.';
  const sher = 'mit';
  const fir = 'ra';
  const rah = 'kon';
  const bung = 'ter.';
  const yun = 'com';
  final bsrl = [sil, ros, mau, sher, fir, rah, bung, yun].join('');
  return bsrl;
}

final String baseUrl = _base();
final String baseUrlCallback = _baseReg();

String getPathAfterGuest(String url) {
  if (!url.contains('guest/')) return '';
  final parts = url.split('guest/');
  return parts.length > 1 ? parts[1] : '';
}

class ApiClientGuest {
  static final Dio _dio = _createDio(baseUrl);
  static final Dio _dioCallback = _createDio(baseUrlCallback);

  static Dio get dio => _dio;

  static Dio get dioCallback => _dioCallback;
  static Duration _to = Duration(minutes: 1);

  static Dio _createDio(String baseUrl) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        sendTimeout: _to,
        receiveTimeout: _to,
        connectTimeout: _to,
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
          HttpHeaders.acceptHeader: "application/json",
        },
      ),
    );

    dio.interceptors.add(_AppInterceptor());

    return dio;
  }
}

class _AppInterceptor extends QueuedInterceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final isOnline = await ConnectivityService().isOnline();

    if (!isOnline) {
      return handler.reject(
        DioException(
          requestOptions: options,
          type: DioExceptionType.connectionError,
          error: 'Tidak ada koneksi internet',
        ),
      );
    }


    try {
      final dataMap = {};
    } catch (e) {
      // Handle any errors if necessary
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
