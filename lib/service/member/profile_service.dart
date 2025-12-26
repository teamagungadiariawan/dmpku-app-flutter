import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/helpers/location_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/model/device_response.dart';
import 'package:dmpku/model/profile_detail_response.dart';
import 'package:dmpku/model/profile_response.dart';
import 'package:flutter/material.dart';

class ProfileService {
  final _dio = ApiClient.dio;

  Future<BaseResponse<ProfileModel>> getProfile() async {
    try {
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

  Future<BaseResponse<ProfileDetailResponse>> getProfileDetail() async {
    try {
      final response = await _dio.post("member/profil/profildetail", data: {});

      final result = BaseResponse.fromJson(
        response.data,
        fromJsonT: (json) => ProfileDetailResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PROFILE DETAIL SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse<ListDeviceResponse>> getProfileDevice() async {
    try {
      final response = await _dio.post("member/profil/device", data: {});

      final result = BaseResponse<ListDeviceResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListDeviceResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PROFILE DETAIL SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> deleteDevice({
    required String perangkat,
    required String pintrx,
  }) async {
    try {
      var loc = await getLocation();

      final response = await _dio.post(
        "member/profil/hapusdevice",
        data: {"perangkat": perangkat, "pintrx": pintrx, "longitude": loc},
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION DELETE DEVICE SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> resetPin() async {
    try {
      var loc = await getLocation();
      var kodemember = await SecureStorageHelper.instance.read(
        StorageKeys.kodeMember,
      );

      final response = await _dio.post(
        "member/profil/resetpin",
        data: {"longitude": loc, "kodemember": kodemember},
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION RESET PIN SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> gantiPin({
    required String pinlama,
    required String pinbaru,
  }) async {
    try {
      var loc = await getLocation();
      var kodemember = await SecureStorageHelper.instance.read(
        StorageKeys.kodeMember,
      );

      final response = await _dio.post(
        "member/profil/gantipin",
        data: {
          "pinlama": pinlama,
          "pinbaru": pinbaru,
          "longitude": loc,
          "kodemember": kodemember,
        },
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GANTI PIN SERVICE: $e");
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
