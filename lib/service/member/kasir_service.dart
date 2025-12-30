import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/model/catatan_response.dart';
import 'package:dmpku/model/kasir_payload.dart';
import 'package:dmpku/model/kasir_response.dart';
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

  // -----------------------------------------------------------------------------
  // TRANSAKSI
  // -----------------------------------------------------------------------------

  Future<BaseResponse<ListPenjualanResponse>> getListPenjualan({
    required String waktuawal,
    required String waktuakhir,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/listPenjualan",
        data: {
          'waktuawal': waktuawal,
          'waktuakhir': waktuakhir,
          'kodemember': kodemember,
        },
      );

      final result = BaseResponse<ListPenjualanResponse>.fromJson(
        response.data,
        fromJsonT: (json) => ListPenjualanResponse.fromJson(json as List?),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GET LIST PENJUALAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse<List<ListPenjualanDetailModel>>> getListPenjualanDetail({
    required int idpenjualan,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/listPenjualanDetail",
        data: {'idpenjualan': idpenjualan, 'kodemember': kodemember},
      );

      final result = BaseResponse<List<ListPenjualanDetailModel>>.fromJson(
        response.data,
        fromJsonT: (json) => (json as List)
            .map((e) => ListPenjualanDetailModel.fromJson(e))
            .toList(),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GET LIST PENJUALAN DETAIL: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> inputPenjualan({
    required int uangpelanggan,
    required int idpelanggan,
    required int kembalian,
    required String kodemember,
    required List<PenjualanPayload> data,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/inputPenjualan",
        data: {
          'uangpelanggan': uangpelanggan,
          'idpelanggan': idpelanggan,
          'kembalian': kembalian,
          'kodemember': kodemember,
          'data': data.map((e) => e.toJson()).toList(),
        },
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION INPUT PENJUALAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> inputPenjualanManual({
    required String kodemember,
    required int idpelanggan,
    required int jumlah,
    required String namaproduk,
    required int hargamodal,
    required int hargaproduk,
    required int uangpelanggan,
    required int kembalian,
    required String satuan,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/inputPenjualanManual",
        data: {
          'kodemember': kodemember,
          'idpelanggan': idpelanggan,
          'jumlah': jumlah,
          'namaproduk': namaproduk,
          'hargamodal': hargamodal,
          'hargaproduk': hargaproduk,
          'uangpelanggan': uangpelanggan,
          'kembalian': kembalian,
          'satuan': satuan,
        },
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION INPUT PENJUALAN MANUAL: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> sukseskanPenjualan({
    required int idpenjualan,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/sukseskanPenjualan",
        data: {'idpenjualan': idpenjualan, 'kodemember': kodemember},
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION SUKSESKAN PENJUALAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> refundPenjualan({
    required int idpenjualan,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/refundPenjualan",
        data: {'idpenjualan': idpenjualan, 'kodemember': kodemember},
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION REFUND PENJUALAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  // -----------------------------------------------------------------------------
  // PELANGGAN
  // -----------------------------------------------------------------------------

  Future<BaseResponse<List<PelangganModel>>> getPelanggan(
    String kodemember,
  ) async {
    try {
      final response = await _dio.post(
        "member/kasir/pelangganlist",
        data: {'kodemember': kodemember},
      );

      final result = BaseResponse<List<PelangganModel>>.fromJson(
        response.data,
        fromJsonT: (json) =>
            (json as List).map((e) => PelangganModel.fromJson(e)).toList(),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GET PELANGGAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> tambahPelanggan({
    required String namapelanggan,
    required String alamatpelanggan,
    required String nohppelanggan,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/pelangganadd",
        data: {
          'namapelanggan': namapelanggan,
          'alamatpelanggan': alamatpelanggan,
          'nohppelanggan': nohppelanggan,
          'kodemember': kodemember,
        },
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION TAMBAH PELANGGAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> ubahPelanggan({
    required int idpelanggan,
    required String namapelanggan,
    required String alamatpelanggan,
    required String nohppelanggan,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/pelangganedit",
        data: {
          'idpelanggan': idpelanggan,
          'namapelanggan': namapelanggan,
          'alamatpelanggan': alamatpelanggan,
          'nohppelanggan': nohppelanggan,
          'kodemember': kodemember,
        },
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION UBAH PELANGGAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> hapusPelanggan({
    required int idpelanggan,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/pelanggandelete",
        data: {'idpelanggan': idpelanggan, 'kodemember': kodemember},
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION HAPUS PELANGGAN: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  // -----------------------------------------------------------------------------
  // PRODUK
  // -----------------------------------------------------------------------------

  Future<BaseResponse<List<ProdukModel>>> getListProduk(
    String kodemember,
  ) async {
    try {
      final response = await _dio.post(
        "member/kasir/produklist",
        data: {'kodemember': kodemember},
      );

      final result = BaseResponse<List<ProdukModel>>.fromJson(
        response.data,
        fromJsonT: (json) =>
            (json as List).map((e) => ProdukModel.fromJson(e)).toList(),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GET LIST PRODUK: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> tambahProduk({
    required String kodemember,
    required String namaproduk,
    required int hargamodal,
    required int hargaproduk,
    required String satuan,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/produkadd",
        data: {
          'kodemember': kodemember,
          'namaproduk': namaproduk,
          'hargamodal': hargamodal,
          'hargaproduk': hargaproduk,
          'satuan': satuan,
        },
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION TAMBAH PRODUK: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> ubahProduk({
    required int idproduk,
    required String kodemember,
    required String namaproduk,
    required int hargamodal,
    required int hargaproduk,
    required String satuan,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/produkedit",
        data: {
          'idproduk': idproduk,
          'kodemember': kodemember,
          'namaproduk': namaproduk,
          'hargamodal': hargamodal,
          'hargaproduk': hargaproduk,
          'satuan': satuan,
        },
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION UBAH PRODUK: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse> hapusProduk({
    required int idproduk,
    required String kodemember,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/produkdelete",
        data: {'idproduk': idproduk, 'kodemember': kodemember},
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION HAPUS PRODUK: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  // -----------------------------------------------------------------------------
  // LAPORAN
  // -----------------------------------------------------------------------------

  Future<BaseResponse<List<LaporanKasirModel>>> getLaporanKasir({
    required String kodemember,
    required String waktuawal,
    required String waktuakhir,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/laporanPenjualanList",
        data: {
          'kodemember': kodemember,
          'waktuawal': waktuawal,
          'waktuakhir': waktuakhir,
        },
      );

      final result = BaseResponse<List<LaporanKasirModel>>.fromJson(
        response.data,
        fromJsonT: (json) =>
            (json as List).map((e) => LaporanKasirModel.fromJson(e)).toList(),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GET LAPORAN KASIR: $e");
      throw ServerException.fromDio(e: e);
    }
  }

  Future<BaseResponse<List<TotalLaporanKasirModel>>> getTotalLaporanKasir({
    required String kodemember,
    required String waktuawal,
    required String waktuakhir,
  }) async {
    try {
      final response = await _dio.post(
        "member/kasir/laporanPenjualan",
        data: {
          'kodemember': kodemember,
          'waktuawal': waktuawal,
          'waktuakhir': waktuakhir,
        },
      );

      final result = BaseResponse<List<TotalLaporanKasirModel>>.fromJson(
        response.data,
        fromJsonT: (json) => (json as List)
            .map((e) => TotalLaporanKasirModel.fromJson(e))
            .toList(),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION GET TOTAL LAPORAN KASIR: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
