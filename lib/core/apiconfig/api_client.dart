import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dmpku/core/helpers/connection_helper.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/encrypt_helper.dart';
import 'package:dmpku/core/helpers/keyboard_helper.dart';
import 'package:dmpku/core/helpers/location_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/pages/guest/main_page.dart';
import 'package:flutter/cupertino.dart';

import 'base_url.dart';

String getPathAfterMember(String url) {
  if (!url.contains('member/')) return '';
  final parts = url.split('member/');
  return parts.length > 1 ? parts[1] : '';
}

class ApiClient {
  static final Dio _dio = _createDio(baseUrl + "/api/");
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
    try {
      final isOnline = await ConnectivityService().checkConnection();
      closeKeyBoard();

      // Ubah ini - hapus casting ke Map<dynamic, dynamic>
      // dan buat map baru dengan tipe yang benar
      final dataMap = Map<String, dynamic>.from((options.data as Map?) ?? {});

      var headers = options.headers;

      var fmcUser = (await SecureStorageHelper.instance.read(StorageKeys.tokenFcm)) ?? '';
      var keteragan = await getKeterangan();

      var location = await getLocation();
      if (dataMap.containsKey("location")) {
        location = dataMap["location"];
      }

      var part = getPathAfterMember(options.path);

      debugPrint("type of dataMap: ${dataMap.runtimeType}");

      dataMap["fmcuser"] = fmcUser;
      dataMap["keterangan"] = '$keteragan - $location';
      dataMap["uuid"] = await getDeviceId2();
      dataMap["version"] = await getVersion();
      dataMap["part"] = part;

      debugPrint("Request DATA : $dataMap");

      var encData = EncryptHelper.encrypt(dataMap);

      headers["ariawan"] = encData.a;
      headers["version"] = await getVersion();
      headers["time"] = DateHelper.currentIso8601StringZ();

      var token = await SecureStorageHelper.instance.getToken();
      if (token != null && token.isNotEmpty) {
        headers["Authorization"] = "Bearer $token";
      }

      var hslEnc = EncryptHelper.encrypt(dataMap);

      options.data = {"a": hslEnc.a};
      options.headers = headers;

      debugPrint("Request URL: ${options.uri}");
      debugPrint("Request HEader: ${options.headers}");
      debugPrint("Request Encrypted Data: ${hslEnc.a}");

      if (!isOnline) {
        return handler.reject(
          DioException(
            requestOptions: options,
            type: DioExceptionType.connectionError,
            error: 'Tidak ada koneksi internet',
          ),
        );
      }
    } catch (e, stackTrace) {
      debugPrint('═══════════════════════════════════');
      debugPrint('ERROR: $e');
      debugPrint('STACK TRACE:');
      debugPrint(stackTrace.toString());
      debugPrint('═══════════════════════════════════');
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      debugPrint("Response Status Code: ${response.statusCode}");

      debugPrint("Response Data: ${response.data}");

      if (response.data == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          type: DioExceptionType.badResponse,
          error: 'Response data is null',
        );
      }

      var data = response.data;

      if (data["a"] != null) {
        var enc = Encrypted(a: data["a"] as String);
        var decryptedData = EncryptHelper.decrypt(enc);
        debugPrint("Decrypted Response Data: $decryptedData");
        response.data = decryptedData;
      } else {
        debugPrint("No encrypted data found in response.");
      }
    } catch (e) {
      debugPrint("Error during response decryption: $e");
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    super.onError(err, handler);
  }
}
