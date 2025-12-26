import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/model/bank_transfer_response.dart';
import 'package:dmpku/model/buat_tiket_response.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';

class DepositService {
  final _dio = ApiClient.dio;

  Future<BaseResponse<BankTransferResponse>> getListBankTransfer() async {
    try {
      final response = await _dio.post(
        "member/deposit/trfbank/listbank",
        data: {},
      );

      final result = BaseResponse<BankTransferResponse>.fromJson(
        response.data,
        fromJsonT: (json) => BankTransferResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<BuatTiketBankResponse> buatTiketBank({
    required int idbank,
    required int nominal,
  }) async {
    try {
      final response = await _dio.post(
        "member/deposit/trfbank/buattiket",
        data: {"idbank": idbank, "nominal": nominal},
      );

      final result = BuatTiketBankResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<RiwayatTiketBankResponse> getRiwayatTiketBank() async {
    try {
      final response = await _dio.post(
        "member/deposit/trfbank/riwayat",
        data: {},
      );

      final result = RiwayatTiketBankResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Alfamart
  Future<BuatTiketAlfamartResponse> buatTiketAlfamart({
    required int nominal,
  }) async {
    try {
      final response = await _dio.post(
        "member/deposit/alfamart/buatkodebayar",
        data: {"nominal": nominal},
      );

      final result = BuatTiketAlfamartResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<RiwayatTiketAlfamartResponse> getRiwayatTiketAlfamart() async {
    try {
      final response = await _dio.post(
        "member/deposit/alfamart/riwayat",
        data: {},
      );

      final result = RiwayatTiketAlfamartResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Indomaret
  Future<BuatTiketIndomaretResponse> buatTiketIndomaret({
    required int nominal,
  }) async {
    try {
      final response = await _dio.post(
        "member/deposit/indomaret/buatkodebayar",
        data: {"nominal": nominal},
      );

      final result = BuatTiketIndomaretResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<RiwayatTiketIndomaretResponse> getRiwayatTiketIndomaret() async {
    try {
      final response = await _dio.post(
        "member/deposit/indomaret/riwayat",
        data: {},
      );

      final result = RiwayatTiketIndomaretResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // QRIS
  Future<BuatTiketQrisResponse> buatTiketQris({
    required int nominal,
  }) async {
    try {
      final response = await _dio.post(
        "member/deposit/qris/buatcode",
        data: {"nominal": nominal},
      );

      final result = BuatTiketQrisResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<RiwayatTiketQRISResponse> getRiwayatTiketQris() async {
    try {
      final response = await _dio.post(
        "member/deposit/qris/riwayat",
        data: {},
      );

      final result = RiwayatTiketQRISResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  // Virtual Account
  Future<BaseResponse<VaBankResponse>> getListBankVa() async {
    try {
      final response = await _dio.post(
        "member/deposit/va/listva",
        data: {},
      );

      final result = BaseResponse<VaBankResponse>.fromJson(
        response.data,
        fromJsonT: (json) => VaBankResponse.fromJson(json),
      );

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<BuatTiketVaResponse> buatTiketVa({
    required int nominal,
    required int idbank,
  }) async {
    try {
      final response = await _dio.post(
        "member/deposit/va/buattiket",
        data: {"nominal": nominal, "idbank": idbank},
      );

      final result = BuatTiketVaResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<RiwayatTiketResponse> getRiwayatTiketVa() async {
    try {
      final response = await _dio.post(
        "member/deposit/va/riwayat",
        data: {},
      );

      final result = RiwayatTiketResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
