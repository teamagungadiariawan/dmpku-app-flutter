import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/model/favorit_response.dart';
import 'package:flutter/material.dart';

class FavoritService {
  final _dio = ApiClient.dio;

  // -----------------------------------------------------------------------------
  // FAVORIT
  // -----------------------------------------------------------------------------
  Future<BaseResponse<ListFavoritResponse>> getFavorit() async {
    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember();

      final response = await _dio.post(
        "member/kasir/favoritlist",
        data: {"kodemember": kodemember},
      );

      final result = BaseResponse<ListFavoritResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListFavoritResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION FAVORIT SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> tambahFavorit({
    required String nama,
    required String nomor,
    required String namakategori,
    required int idkategori,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/favoritadd",
        data: {
          "nama": nama,
          "nomor": nomor,
          "namakategori": namakategori,
          "idkategori": idkategori,
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
      debugPrint("DIO EXCEPTION FAVORIT SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> ubahFavorit({
    required int idfavorit,
    required String nama,
    required String nomor,
    required String namakategori,
    required int idkategori,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/favoritedit",
        data: {
          "idfavorit": idfavorit,
          "nama": nama,
          "nomor": nomor,
          "namakategori": namakategori,
          "idkategori": idkategori,
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
      debugPrint("DIO EXCEPTION FAVORIT SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> hapusFavorit({
    required int idfavorit,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/favoritdelete",
        data: {"idfavorit": idfavorit, "kodemember": kodemember},
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION FAVORIT SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
