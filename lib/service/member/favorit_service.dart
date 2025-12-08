import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/model/favorit_response.dart';
import 'package:flutter/material.dart';

class FavoritService {
  final _dio = ApiClient.dio;

  // -----------------------------------------------------------------------------
  // FAVORIT
  // -----------------------------------------------------------------------------
  Future<BaseResponse<ListFavoritResponse>> getFavorit() async {
    try {
      final response = await _dio.post("member/kasir/favoritlist", data: {});

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
}
