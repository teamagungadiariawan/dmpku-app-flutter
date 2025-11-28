import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client_guest.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/model/informasi_response.dart';
import 'package:flutter/cupertino.dart';

class InformasiService {
  final _dio = ApiClientGuest.dio;

  Future<BaseResponse<InformasiResponse>> getInformasi() async {
    try {
      final response = await _dio.post("guest/informasi", data: {});

      final result = BaseResponse<InformasiResponse>.fromJson(
        response.data,
        fromJsonT: (json) => InformasiResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e,stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION INFORMASI SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
