import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client_guest.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:flutter/material.dart';

class ProdukService {
  final _dio = ApiClientGuest.dio;

  Future<BaseResponse<ListProviderResponse>> getPulsaGuestProviders() async {
    try {
      final response = await _dio.post("guest/pulsa/provider", data: {});

      final result = BaseResponse<ListProviderResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListProviderResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PRODUK SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse<ListProductResponse>> getPulsaGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/pulsa/product",
        data: {'idprovider': idProvider} as Map<dynamic, dynamic>,
      );

      final result = BaseResponse<ListProductResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListProductResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PRODUK SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
