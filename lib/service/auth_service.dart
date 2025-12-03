import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/api_client.dart';
import 'package:dmpku/core/apiconfig/base_response.dart';
import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/encrypt_helper.dart';
import 'package:dmpku/core/helpers/location_helper.dart';

class AuthService {
  final _dio = ApiClient.dio;

  Future<BaseResponse> reqOtpLogin({required String nohpmember}) async {
    try {
      var loc = await getLocation();
      var uuid = await getAndroidId();

      var md5Sign = EncryptHelper.md5SignOtpLogin(
        longitude: loc,
        uuid: uuid,
        nohpmember: nohpmember,
      );

      const path = 'login/otp';
      final response = await _dio.post(
        path,
        data: {"nohpmember": nohpmember},
        options: Options(headers: {'signlogin': md5Sign}),
      );

      final result = BaseResponse.fromJson(response.data);

      if (!result.status) {
        throw Exception(result.message);
      }

      return result;
    } catch (e) {
      rethrow;
    }
  }
}
