import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/helpers/location_helper.dart';
import 'package:dmpku/model/profile_response.dart';
import 'package:flutter/material.dart';

class ProfileService {
  final _dio = ApiClient.dio;

  Future<BaseResponse<ProfileModel>> getProfile() async {
    try {
      // return BaseResponse(
      //   status: true,
      //   message: "Berhasil ambil profile",
      //   data: DEFAULT_PROFILE.copyWith(
      //     kodemember: "DM123456",
      //     namamember: "John Doe",
      //     email: "johndoe@gmail.com",
      //     saldo: 150000,
      //     verifikasi: 0,
      //     userstatus: 1,
      //     status: 1,
      //     isppob: 1,
      //   ),
      // );

      final response = await _dio.post("member/profil/profil", data: {});

      final result = BaseResponse<ProfileModel>.fromJson(
        response.data,
        fromJsonT: (json) => ProfileModel.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PROFILE SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> logout() async {
    try {
      var loc = await getLocation();

      final response = await _dio.post(
        "member/profil/logout",
        data: {"longitude": loc},
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION LOGOUT SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
