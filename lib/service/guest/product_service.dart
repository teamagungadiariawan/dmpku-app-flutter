import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client_guest.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/model/product_cuan_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:flutter/material.dart';

class ProdukService {
  final _dio = ApiClientGuest.dio;

  // -----------------------------------------------------------------------------
  // AKTIVASI PERDANA
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getAktivasiPerdanaGuestProviders() async {
    try {
      final response = await _dio.post("guest/actperdana/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getAktivasiPerdanaGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/actperdana/product",
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
  getAktivasiVoucherGuestProviders() async {
    try {
      final response = await _dio.post("guest/actvoucher/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getAktivasiVoucherGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/actvoucher/product",
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
      final response = await _dio.post("guest/cekvoucher/product", data: {});

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
  getDompetDigitalGuestProviders() async {
    try {
      final response = await _dio.post(
        "guest/dompetdigital/provider",
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

  Future<BaseResponse<ListProductResponse>> getDompetDigitalGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/dompetdigital/product",
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
  getMasaAktifGuestProviders() async {
    try {
      final response = await _dio.post("guest/masaaktif/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getMasaAktifGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/masaaktif/product",
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
  // PAKET CUAN
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getPaketCuanGuestProviders() async {
    try {
      final response = await _dio.post("guest/paketcuan/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>>
  getPaketCuanGuestSubProviders() async {
    try {
      final response = await _dio.post("guest/paketcuan/subprovider", data: {});

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

  Future<BaseResponse<ListProductCuanResponse>>
  getPaketCuanGuestGuestProducts() async {
    try {
      final response = await _dio.post("guest/paketcuan/product", data: {});

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
  getPaketDataGuestProviders() async {
    try {
      final response = await _dio.post("guest/paketdata/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getPaketDataGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/paketdata/product",
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
  // INFO KARTU
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProductResponse>> getInfoKartuProducts() async {
    try {
      final response = await _dio.post("guest/infokartu/product", data: {});

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
  getPaketNelponGuestProviders() async {
    try {
      final response = await _dio.post("guest/paketnelpon/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getPaketNelponGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/paketnelpon/product",
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
  // PULSA
  // -----------------------------------------------------------------------------

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
  // STREAMING
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>>
  getStreamingGuestProviders() async {
    try {
      final response = await _dio.post(
        "guest/paketstreaming/provider",
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

  Future<BaseResponse<ListProductResponse>> getStreamingGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/paketstreaming/product",
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

  Future<BaseResponse<ListProductResponse>> getTokenPlnGuestProducts() async {
    try {
      final response = await _dio.post("guest/tokenpln/product", data: {});

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
  getTopupGameGuestProviders() async {
    try {
      final response = await _dio.post("guest/game/provider", data: {});
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

  Future<BaseResponse<ListProductResponse>> getTopupGameGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/game/product",
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
  // TV
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListProviderResponse>> getTVGuestProviders() async {
    try {
      final response = await _dio.post("guest/pakettv/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getTVGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/pakettv/product",
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
  getUangElektronikGuestProviders() async {
    try {
      final response = await _dio.post(
        "guest/uangelektronik/provider",
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

  Future<BaseResponse<ListProductResponse>> getUangElektronikGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/uangelektronik/product",
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
  getVoucherDataGuestProviders() async {
    try {
      final response = await _dio.post("guest/voucherdata/provider", data: {});

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

  Future<BaseResponse<ListProductResponse>> getVoucherDataGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/voucherdata/product",
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
  getVoucherDigitalGuestProviders() async {
    try {
      final response = await _dio.post(
        "guest/voucherdigital/provider",
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

  Future<BaseResponse<ListProductResponse>> getVoucherDigitalGuestProducts({
    required int idProvider,
  }) async {
    try {
      final response = await _dio.post(
        "guest/voucherdigital/product",
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

  Future<BaseResponse<ListProductResponse>> getWifiIdGuestProducts() async {
    try {
      final response = await _dio.post("guest/wifiid/product", data: {});

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
