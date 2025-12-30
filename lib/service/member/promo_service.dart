import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/tipe_trx.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/model/bayar_response.dart';
import 'package:dmpku/model/cek_tagihan_response.dart';
import 'package:dmpku/model/promo_response.dart';
import 'package:flutter/material.dart';

class PromoService {
  final _dio = ApiClient.dio;

  // -----------------------------------------------------------------------------
  // PROMO
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListPromoProdukResponse>> getProdukPromo() async {
    try {
      var kodemember = await SecureStorageHelper.instance.getKodeMember();

      final response = await _dio.post(
        "member/promo/produkpromo",
        data: {"kodemember": kodemember},
      );

      final result = BaseResponse<ListPromoProdukResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListPromoProdukResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GET PRODUK PROMO: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<CekTagihanResponse> cekAkun({
    required String kodeproduk,
    required String tujuan,
  }) async {
    try {
      final response = await _dio.post(
        "member/promo/cekakun",
        data: {
          'kodeproduk': kodeproduk,
          'tujuan': tujuan,
          "jenistrx": TipeTrx.cekAkun.value,
          "tujuantambahan": 'kosong',
        },
      );
      final result = CekTagihanResponse.fromJson(response.data);

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION CEK AKUN PROMO: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse<BayarResponse>> bayar({
    required String kodeproduk,
    required String tujuan,
    required String pintrx,
    int trxke = 1,
  }) async {
    try {
      final response = await _dio.post(
        "member/promo/transaksi",
        data: {
          "kodeproduk": kodeproduk,
          "tujuan": tujuan,
          "pintrx": pintrx,
          "trxke": trxke,
        },
      );

      final result = BaseResponse<BayarResponse>.fromJson(
        response.data,
        fromJsonT: (json) => BayarResponse.fromJson(json),
      );

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION BAYAR PROMO: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
