import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:flutter/material.dart';

class RiwayatService {
  final _dio = ApiClient.dio;

  Future<BaseResponse<ListRiwayatResponse>> getRiwayatToday({
    String tujuan = '',
    String kodeproduk = '',
    String namaproduk = '',
    int page = 1,
  }) async {
    try {
      final response = await _dio.post(
        "member/riwayat/transaksitoday",
        data: {
          "tujuan": tujuan,
          "kodeproduk": kodeproduk,
          "namaproduk": namaproduk,
          "page": page,
        },
      );

      final result = BaseResponse<ListRiwayatResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListRiwayatResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION RIWAYAT SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse<ListRiwayatResponse>> getRiwayatHistory({
    String waktuawal = '',
    String waktuakhir = '',
    String tujuan = '',
    String kodeproduk = '',
    String namaproduk = '',
    int page = 1,
  }) async {
    if (waktuawal.isEmpty) {
      var waktuAwal = DateTime.now().subtract(const Duration(days: 3));
      waktuawal = DateHelper.formatDate(waktuAwal);
    }

    if (waktuakhir.isEmpty) {
      var waktuAkhir = DateTime.now();
      waktuakhir = DateHelper.formatDate(waktuAkhir);
    }

    try {
      final response = await _dio.post(
        "member/riwayat/transaksihistory",
        data: {
          "waktuawal": waktuawal,
          "waktuakhir": waktuakhir,
          "tujuan": tujuan,
          "kodeproduk": kodeproduk,
          "namaproduk": namaproduk,
          "page": page,
        },
      );

      final result = BaseResponse<ListRiwayatResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListRiwayatResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION RIWAYAT SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse<ListMutasiSaldoResponse>> getMutasiSaldo({
    String tujuan = '',
    String waktuawal = '',
    String waktuakhir = '',
    int page = 1,
  }) async {
    if (waktuawal.isEmpty) {
      var waktuAwal = DateTime.now().subtract(const Duration(days: 3));
      waktuawal = DateHelper.formatDate(waktuAwal);
    }

    if (waktuakhir.isEmpty) {
      var waktuAkhir = DateTime.now();
      waktuakhir = DateHelper.formatDate(waktuAkhir);
    }

    try {
      final response = await _dio.post(
        "member/riwayat/riwayatmutasisaldo",
        data: {
          "tujuan": tujuan,
          "waktuawal": waktuawal,
          "waktuakhir": waktuakhir,
          "page": page,
        },
      );

      final result = BaseResponse<ListMutasiSaldoResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListMutasiSaldoResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION MUTASI SALDO SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse<ListRekapTransaksiResponse>> getRekapTransaksi({
    String waktu = '',
    String tujuan = '',
    int page = 1,
  }) async {
    if (waktu.isEmpty) {
      var waktuAwal = DateTime.now().subtract(const Duration(days: 3));
      waktu = DateHelper.formatDate(waktuAwal);
    }

    try {
      final response = await _dio.post(
        "member/riwayat/riwayatrekaptransaksi",
        data: {"waktu": waktu, "tujuan": tujuan},
      );

      final result = BaseResponse<ListRekapTransaksiResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListRekapTransaksiResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION RIWAYAT SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<DetailTransaksiResponse> getDetailTransaksiToday({
    required int idtransaksiprod,
  }) async {
    try {
      final response = await _dio.post(
        "member/riwayat/transaksitoday/detail",
        data: {"idtransaksiprod": idtransaksiprod},
      );

      final result = DetailTransaksiResponse.fromJson(response.data);

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION DETAIL TRANSAKSI SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<DetailTransaksiResponse> getDetailTransaksiHistory({
    required int idtransaksiprod,
  }) async {
    try {
      final response = await _dio.post(
        "member/riwayat/transaksihistory/detail",
        data: {"idtransaksiprod": idtransaksiprod},
      );

      final result = DetailTransaksiResponse.fromJson(response.data);

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION DETAIL TRANSAKSI SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
