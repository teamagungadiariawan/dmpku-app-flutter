import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/tipe_trx.dart';
import 'package:dmpku/model/bayar_response.dart';
import 'package:dmpku/model/cek_tagihan_response.dart';
import 'package:dmpku/model/product_cuan_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:flutter/material.dart';

class ProdukService {
  final _dio = ApiClient.dio;

  // -----------------------------------------------------------------------------
  // AKTIVASI PERDANA
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getAktivasiPerdanaMemberProviders() async {
    try {
      final response = await _dio.post("member/actperdana/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getAktivasiPerdanaMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/actperdana/product",
        data: {'idprovider': idProvider},
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

  // -----------------------------------------------------------------------------
  // AKTIVASI VOUCHER
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getAktivasiVoucherMemberProviders() async {
    try {
      final response = await _dio.post("member/actvoucher/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getAktivasiVoucherMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/actvoucher/product",
        data: {'idprovider': idProvider},
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

  // -----------------------------------------------------------------------------
  // CEK STATUS VOUCHER
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProductResponse>>
  getCekStatusVoucherProducts() async {
    try {
      final response = await _dio.post("member/cekvoucher/product", data: {});

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

  // -----------------------------------------------------------------------------
  // DOMPET DIGITAL
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getDompetDigitalMemberProviders() async {
    try {
      final response = await _dio.post(
        "member/dompetdigital/provider",
        data: {},
      );

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

  Future<BaseResponse<ListProductResponse>> getDompetDigitalMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/dompetdigital/product",
        data: {'idprovider': idProvider},
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

  // -----------------------------------------------------------------------------
  // MASA AKTIF
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getMasaAktifMemberProviders() async {
    try {
      final response = await _dio.post("member/masaaktif/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getMasaAktifMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/masaaktif/product",
        data: {'idprovider': idProvider},
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

  Future<BaseResponse<BayarResponse>> bayarMasaAktifMember({
    required String kodeproduk,
    required String tujuan,
    required String pintrx,
    trxke = 1,
  }) async {
    try {
      final response = await _dio.post(
        "member/pulsa/transaksi",
        data: {
          "kodeproduk": kodeproduk,
          "tujuan": tujuan,
          "tujuantambahan": 'kosong',
          "jenistrx": TipeTrx.elektrik.value,
          "pintrx": pintrx,
          "trxke": trxke,
          "kodebayar": 'kosong',
          "nominaltrx": 0,
        },
      );

      final result = BaseResponse<BayarResponse>.fromJson(
        response.data,
        fromJsonT: (json) => BayarResponse.fromJson(json),
      );

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PRODUK SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  // -----------------------------------------------------------------------------
  // PAKET CUAN
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getPaketCuanMemberProviders() async {
    try {
      final response = await _dio.post("member/paketcuan/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getPaketCuanMemberSubProviders({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/paketcuan/subprovider",
        data: {'idprovider': idProvider},
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

  Future<BaseResponse<ListProductCuanResponse>> getPaketCuanMemberProducts({
    required String kodeproduk,
    required String tujuan,
  }) async {
    try {
      final response = await _dio.post(
        "member/paketcuan/product",
        data: {'kodeproduk': kodeproduk, 'tujuan': tujuan},
      );

      final result = BaseResponse<ListProductCuanResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListProductCuanResponse.fromJson(json),
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

  // -----------------------------------------------------------------------------
  // PAKET DATA
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getPaketDataMemberProviders() async {
    try {
      final response = await _dio.post("member/paketdata/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getPaketDataMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/paketdata/product",
        data: {'idprovider': idProvider},
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

  Future<BaseResponse<BayarResponse>> bayarPaketDataMember({
    required String kodeproduk,
    required String tujuan,
    required String pintrx,
    trxke = 1,
  }) async {
    try {
      final response = await _dio.post(
        "member/paketdata/transaksi",
        data: {
          "kodeproduk": kodeproduk,
          "tujuan": tujuan,
          "tujuantambahan": 'kosong',
          "jenistrx": TipeTrx.elektrik.value,
          "pintrx": pintrx,
          "trxke": trxke,
          "kodebayar": 'kosong',
          "nominaltrx": 0,
        },
      );

      final result = BaseResponse<BayarResponse>.fromJson(
        response.data,
        fromJsonT: (json) => BayarResponse.fromJson(json),
      );

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PRODUK SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  // -----------------------------------------------------------------------------
  // INFO KARTU
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProductResponse>> getInfoKartuProducts() async {
    try {
      final response = await _dio.post("member/infokartu/product", data: {});

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

  // -----------------------------------------------------------------------------
  // PAKET NELPON
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getPaketNelponMemberProviders() async {
    try {
      final response = await _dio.post("member/paketnelpon/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getPaketNelponMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/paketnelpon/product",
        data: {'idprovider': idProvider},
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

  Future<BaseResponse<BayarResponse>> bayarPaketNelponMember({
    required String kodeproduk,
    required String tujuan,
    required String pintrx,
    trxke = 1,
  }) async {
    try {
      final response = await _dio.post(
        "member/pulsa/transaksi",
        data: {
          "kodeproduk": kodeproduk,
          "tujuan": tujuan,
          "tujuantambahan": 'kosong',
          "jenistrx": TipeTrx.elektrik.value,
          "pintrx": pintrx,
          "trxke": trxke,
          "kodebayar": 'kosong',
          "nominaltrx": 0,
        },
      );

      final result = BaseResponse<BayarResponse>.fromJson(
        response.data,
        fromJsonT: (json) => BayarResponse.fromJson(json),
      );

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PRODUK SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  // -----------------------------------------------------------------------------
  // PULSA
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>> getPulsaMemberProviders() async {
    try {
      final response = await _dio.post("member/pulsa/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getPulsaMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/pulsa/product",
        data: {'idprovider': idProvider},
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

  Future<BaseResponse<BayarResponse>> bayarPulsaMember({
    required String kodeproduk,
    required String tujuan,
    required String pintrx,
    trxke = 1,
  }) async {
    try {
      final response = await _dio.post(
        "member/pulsa/transaksi",
        data: {
          "kodeproduk": kodeproduk,
          "tujuan": tujuan,
          "tujuantambahan": 'kosong',
          "jenistrx": TipeTrx.elektrik.value,
          "pintrx": pintrx,
          "trxke": trxke,
          "kodebayar": 'kosong',
          "nominaltrx": 0,
        },
      );

      final result = BaseResponse<BayarResponse>.fromJson(
        response.data,
        fromJsonT: (json) => BayarResponse.fromJson(json),
      );

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION PRODUK SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  // -----------------------------------------------------------------------------
  // STREAMING
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getStreamingMemberProviders() async {
    try {
      final response = await _dio.post(
        "member/paketstreaming/provider",
        data: {},
      );

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

  Future<BaseResponse<ListProductResponse>> getStreamingMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/paketstreaming/product",
        data: {'idprovider': idProvider},
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

  // -----------------------------------------------------------------------------
  // TOKEN PLN
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProductResponse>> getTokenPlnMemberProducts() async {
    try {
      final response = await _dio.post("member/tokenpln/product", data: {});

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

  // -----------------------------------------------------------------------------
  // TOPUP GAME
  // -----------------------------------------------------------------------------

  Future<BaseResponse<TopupGameProviderResponse>>
  getTopupGameMemberProviders() async {
    try {
      final response = await _dio.post("member/game/provider", data: {});
      final result = BaseResponse<TopupGameProviderResponse>.fromJson(
        response.data,
        fromJsonT: (json) => TopupGameProviderResponse.fromJson(json),
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

  Future<BaseResponse<ListProductResponse>> getTopupGameMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/game/product",
        data: {'idprovider': idProvider},
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

  Future<CekTagihanResponse> cekAkunGame({
    required String kodeproduk,
    required String tujuan,
  }) async {
    try {
      final response = await _dio.post(
        "member/game/cekakun",
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
      debugPrint("DIO EXCEPTION PRODUK SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  // -----------------------------------------------------------------------------
  // TV
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>> getTVMemberProviders() async {
    try {
      final response = await _dio.post("member/pakettv/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getTVMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/pakettv/product",
        data: {'idprovider': idProvider},
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

  // -----------------------------------------------------------------------------
  // UANG ELEKTRONIK
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getUangElektronikMemberProviders() async {
    try {
      final response = await _dio.post(
        "member/uangelektronik/provider",
        data: {},
      );

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

  Future<BaseResponse<ListProductResponse>> getUangElektronikMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/uangelektronik/product",
        data: {'idprovider': idProvider},
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

  // -----------------------------------------------------------------------------
  // VOUCHER DATA
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getVoucherDataMemberProviders() async {
    try {
      final response = await _dio.post("member/voucherdata/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getVoucherDataMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/voucherdata/product",
        data: {'idprovider': idProvider},
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

  // -----------------------------------------------------------------------------
  // VOUCHER DIGITAL
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getVoucherDigitalMemberProviders() async {
    try {
      final response = await _dio.post(
        "member/voucherdigital/provider",
        data: {},
      );

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

  Future<BaseResponse<ListProductResponse>> getVoucherDigitalMemberProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "member/voucherdigital/product",
        data: {'idprovider': idProvider},
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

  // -----------------------------------------------------------------------------
  // WIFI ID
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProductResponse>> getWifiIdMemberProducts() async {
    try {
      final response = await _dio.post("member/wifiid/product", data: {});

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
