import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client_guest.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/model/informasi_response.dart';
import 'package:flutter/cupertino.dart';

class InformasiService {
  final _dio = ApiClientGuest.dio;

  Future<InformasiResponse> getInformasi() async {
    try {
      final response = await _dio.post("guest/informasi", data: {});
      final result = InformasiResponse.fromJson(response.data);

      if (!result.status) {
        throw ServerException.fromDio(r: response);
      }

      var data = result;

      if (data != null) {
        if (data.cs.isNotEmpty) {
          for (var contact in data.cs) {
            if (contact.key.toLowerCase().contains("whatsapp") ||
                contact.key.contains("wa")) {
              SecureStorageHelper.instance.saveWacs(contact.value);
            }

            if (contact.key.toLowerCase().contains("call center")) {
              SecureStorageHelper.instance.saveCallCenter(contact.value);
            }
          }

          if (data.chanel.isNotEmpty) {
            for (var channel in data.chanel) {
              if (channel.key.toLowerCase().contains("whatsapp") ||
                  channel.key.contains("wa")) {
                SecureStorageHelper.instance.saveChannelWa(channel.value);
              }
            }
          }

          if (data.playstore.isNotEmpty) {
            var playstoreLink = data.playstore[0];
            SecureStorageHelper.instance.savePlayStore(playstoreLink.value);
          }
        }
      }

      return result;
    } on DioException catch (e, stackTrace) {
      debugPrintStack(stackTrace: stackTrace);
      debugPrint("DIO EXCEPTION INFORMASI SERVICE: $e");
      throw ServerException.fromDio(e: e);
    }
  }
}
