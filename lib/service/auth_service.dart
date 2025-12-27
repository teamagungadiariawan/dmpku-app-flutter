import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/encrypt_helper.dart';

import 'package:flutter/material.dart';

class AuthService {
  final _dio = ApiClient.dio;

  Future<BaseResponse> reqOtpLogin({
    required String nohpmember,
    required String loc,
  }) async {
    try {
      var uuid = await getAndroidId();

      var md5Sign = EncryptHelper.md5SignOtpLogin(
        longitude: loc,
        uuid: uuid,
        nohpmember: nohpmember,
      );

      // return BaseResponse(
      //   status: true,
      //   durasi: "2025-12-04T13:18:00+07:00",
      //   hashloginotp: "c947b65d76457c60e6d63028765149ca",
      //   message: "Otp Login Berhasil Dikirim",
      // );

      const path = 'login/otp';
      final response = await _dio.post(
        path,
        data: {"nohpmember": nohpmember, "longitude": loc},
        options: Options(headers: {'signlogin': md5Sign}),
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION AUTH SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> verOtpLogin({
    required String nohpmember,
    required String otp,
    required String hashloginotp,
    required String loc,
  }) async {
    try {
      var uuid = await getAndroidId();

      var md5Sign = EncryptHelper.md5SignVerifyOtpLogin(
        uuid: uuid,
        nohpmember: nohpmember,
        otp: otp,
      );

      const path = 'login/otpverifikasi';
      final response = await _dio.post(
        path,
        data: {
          "nohpmember": nohpmember,
          "otp": otp,
          "hashloginotp": hashloginotp,
          "longitude": loc,
        },
        options: Options(
          headers: {'signloginverify': md5Sign, "hashloginotp": hashloginotp},
        ),
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION AUTH SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
