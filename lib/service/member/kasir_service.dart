import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/model/catatan_response.dart';
import 'package:flutter/material.dart';

class KasirService {
  final _dio = ApiClient.dio;

  // -----------------------------------------------------------------------------
  // CATATAN
  // -----------------------------------------------------------------------------
  Future<BaseResponse<ListCatatanResponse>> getCatatan() async {
    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember();

      // Assuming GET route or POST with just kodemember, matching React Native 'KasirService.getCatatan(profile.kodemember)'
      // React Native code: KasirService.getCatatan(profile.kodemember) -> likely calls 'member/kasir/catatanlist' based on context in User Request

      final response = await _dio.post(
        "member/kasir/catatanlist",
        data: {"kodemember": kodemember},
      );

      final result = BaseResponse<ListCatatanResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListCatatanResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GET CATATAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> tambahCatatan(TambahCatatanPayload payload) async {
    try {
      final response = await _dio.post(
        "member/kasir/catatanadd",
        data: payload.toJson(),
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION TAMBAH CATATAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> ubahCatatan(UbahCatatanPayload payload) async {
    try {
      final response = await _dio.post(
        "member/kasir/catatanedit",
        data: payload.toJson(),
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION UBAH CATATAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> hapusCatatan(HapusCatatanPayload payload) async {
    try {
      final response = await _dio.post(
        "member/kasir/catatandelete",
        data: payload.toJson(),
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION HAPUS CATATAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
