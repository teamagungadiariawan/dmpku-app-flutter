import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
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
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    dio.interceptors.add(_AppInterceptor());

    return dio;
  }
}

class _AppInterceptor extends Interceptor {
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

      var fmcUser =
          (await SecureStorageHelper.instance.read(StorageKeys.tokenFcm)) ?? '';
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
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    try {
      debugPrint("Response Status Code: ${response.statusCode}");

      if (response.data == null) {
        throw DioException(
          requestOptions: response.requestOptions,
          type: DioExceptionType.badResponse,
          error: 'Response data is null',
        );
      }

      var data = response.data;
      var code = response.statusCode ?? 0;

      if (data["a"] != null) {
        var enc = Encrypted(a: data["a"] as String);
        var decryptedData = EncryptHelper.decrypt(enc);
        debugPrint("Decrypted Response Data: $decryptedData");

        // get message from decrypted data if exists
        var message = decryptedData["message"] ?? '';
        // remove nonalphanumeric characters from message
        message = message.replaceAll(RegExp(r'[^a-zA-Z0-9 ]'), '');
        //remove spaces from message
        message = message.replaceAll(' ', '').toLowerCase();

        debugPrint("Normalized Message: $message");

        if (code == 401) {
          if (message.contains('tokeninvalid') ||
              message.contains('tokentidakvalid')) {
            debugPrint("Refresh Token");

            var refreshed = await refreshToken();
            if (!refreshed) {
              await SecureStorageHelper.instance.clearToken();
              await SecureStorageHelper.instance.clearRefreshToken();
              debugPrint(
                "Token tidak valid. Token telah dihapus dari penyimpanan.",
              );
              pushNamedAndRemoveUntil(MainPage.routeName);
            } else {
              // Retry the original request
              final options = response.requestOptions;
              final cloneReq = await ApiClient.dio.request(
                options.path,
                options: Options(
                  method: options.method,
                  headers: options.headers,
                ),
                data: options.data,
                queryParameters: options.queryParameters,
              );
              return handler.resolve(cloneReq);
            }
          }
        }

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
    debugPrint("Dio Error: ${err.message}");

    super.onError(err, handler);
  }
}

Future<bool> refreshToken() async {
  try {
    var token = await SecureStorageHelper.instance.getToken();
    var refreshToken = await SecureStorageHelper.instance.getRefreshToken();
    var kodeMember = await SecureStorageHelper.instance.read(
      StorageKeys.kodeMember,
    );
    var uuid = await getDeviceId2();
    var fmcUser = await SecureStorageHelper.instance.read(StorageKeys.tokenFcm);

    final response = await ApiClient.dio.post(
      "login/refreshtoken",
      data: {
        "token": token,
        "refreshtoken": refreshToken,
        "kodemember": kodeMember,
        "uuid": uuid,
        "fmcuser": fmcUser,
      },
    );

    final result = BaseResponse.fromJson(response.data);

    if (result.status) {
      await SecureStorageHelper.instance.saveToken(result.token);
      await SecureStorageHelper.instance.saveRefreshToken(result.refresh);
      await SecureStorageHelper.instance.write(
        StorageKeys.signmember,
        result.signmember,
      );
      return true;
    } else {
      return false;
    }
  } on DioException catch (e, stackTrace) {
    debugPrintStack(stackTrace: stackTrace);
    debugPrint("DIO EXCEPTION AUTH SERVICE: $e");
    return false;
  }
}
