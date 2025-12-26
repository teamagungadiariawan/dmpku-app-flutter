import 'package:dio/dio.dart';
import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/device_response.dart';
import 'package:dmpku/model/profile_detail_response.dart';
import 'package:dmpku/model/profile_response.dart';
import 'package:dmpku/pages/guest/main_page.dart';
import 'package:dmpku/service/member/profile_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// STATE
// ============================================================

class MemberState extends Equatable {
  // Member API
  final ApiStatus apiGetMemberStatus;
  final String apiGetMemberMessage;
  final ProfileModel profile;

  // Logout API
  final ApiStatus apiLogoutStatus;
  final String apiLogoutMessage;

  // Member Detail API
  final ApiStatus apiGetMemberDetailStatus;
  final String apiGetMemberDetailMessage;
  final ProfileDetailModel profileDetail;

  // Member Device API
  final ApiStatus apiGetMemberDeviceStatus;
  final String apiGetMemberDeviceMessage;
  final List<DeviceModel> profileDeviceNumber;
  final List<DeviceModel> profileDevicePhone;

  // Delete Device API
  final ApiStatus apiDeleteMemberDeviceStatus;
  final String apiDeleteMemberDeviceMessage;

  final ApiStatus apiGantiPinStatus;
  final String apiGantiPinMessage;

  final ApiStatus apiResetPinStatus;
  final String apiResetPinMessage;

  const MemberState({
    this.apiGetMemberStatus = ApiStatus.initial,
    this.apiGetMemberMessage = '',
    this.profile = DEFAULT_PROFILE,

    this.apiGetMemberDetailStatus = ApiStatus.initial,
    this.apiGetMemberDetailMessage = '',
    this.profileDetail = DEFAULT_PROFILE_DETAIL_MODEL,

    this.apiGetMemberDeviceStatus = ApiStatus.initial,
    this.apiGetMemberDeviceMessage = '',
    this.profileDeviceNumber = const [],
    this.profileDevicePhone = const [],

    this.apiLogoutStatus = ApiStatus.initial,
    this.apiLogoutMessage = '',

    this.apiDeleteMemberDeviceStatus = ApiStatus.initial,
    this.apiDeleteMemberDeviceMessage = '',

    this.apiGantiPinStatus = ApiStatus.initial,
    this.apiGantiPinMessage = '',

    this.apiResetPinStatus = ApiStatus.initial,
    this.apiResetPinMessage = '',
  });

  MemberState copyWith({
    ApiStatus? apiGetMemberStatus,
    String? apiGetMemberMessage,
    ProfileModel? profile,

    ApiStatus? apiGetMemberDetailStatus,
    String? apiGetMemberDetailMessage,
    ProfileDetailModel? profileDetail,

    ApiStatus? apiGetMemberDeviceStatus,
    String? apiGetMemberDeviceMessage,
    List<DeviceModel>? profileDeviceNumber,
    List<DeviceModel>? profileDevicePhone,

    ApiStatus? apiLogoutStatus,
    String? apiLogoutMessage,

    ApiStatus? apiDeleteMemberDeviceStatus,
    String? apiDeleteMemberDeviceMessage,

    ApiStatus? apiGantiPinStatus,
    String? apiGantiPinMessage,

    ApiStatus? apiResetPinStatus,
    String? apiResetPinMessage,
  }) {
    return MemberState(
      apiGetMemberStatus: apiGetMemberStatus ?? this.apiGetMemberStatus,
      apiGetMemberMessage: apiGetMemberMessage ?? this.apiGetMemberMessage,
      profile: profile ?? this.profile,

      apiGetMemberDetailStatus:
          apiGetMemberDetailStatus ?? this.apiGetMemberDetailStatus,
      apiGetMemberDetailMessage:
          apiGetMemberDetailMessage ?? this.apiGetMemberDetailMessage,
      profileDetail: profileDetail ?? this.profileDetail,

      apiGetMemberDeviceStatus:
          apiGetMemberDeviceStatus ?? this.apiGetMemberDeviceStatus,
      apiGetMemberDeviceMessage:
          apiGetMemberDeviceMessage ?? this.apiGetMemberDeviceMessage,
      profileDeviceNumber: profileDeviceNumber ?? this.profileDeviceNumber,
      profileDevicePhone: profileDevicePhone ?? this.profileDevicePhone,

      apiLogoutStatus: apiLogoutStatus ?? this.apiLogoutStatus,
      apiLogoutMessage: apiLogoutMessage ?? this.apiLogoutMessage,

      apiDeleteMemberDeviceStatus:
          apiDeleteMemberDeviceStatus ?? this.apiDeleteMemberDeviceStatus,
      apiDeleteMemberDeviceMessage:
          apiDeleteMemberDeviceMessage ?? this.apiDeleteMemberDeviceMessage,

      apiGantiPinStatus: apiGantiPinStatus ?? this.apiGantiPinStatus,
      apiGantiPinMessage: apiGantiPinMessage ?? this.apiGantiPinMessage,

      apiResetPinStatus: apiResetPinStatus ?? this.apiResetPinStatus,
      apiResetPinMessage: apiResetPinMessage ?? this.apiResetPinMessage,
    );
  }

  @override
  List<Object?> get props => [
    apiGetMemberStatus,
    apiGetMemberMessage,
    profile,

    apiGetMemberDetailStatus,
    apiGetMemberDetailMessage,
    profileDetail,

    apiGetMemberDeviceStatus,
    apiGetMemberDeviceMessage,
    profileDeviceNumber,
    profileDevicePhone,

    apiLogoutStatus,
    apiLogoutMessage,

    apiDeleteMemberDeviceStatus,
    apiDeleteMemberDeviceMessage,

    apiGantiPinStatus,
    apiGantiPinMessage,

    apiResetPinStatus,
    apiResetPinMessage,
  ];
}

// ============================================================
// CUBIT
// ============================================================

class MemberProvider extends Cubit<MemberState> {
  final ProfileService _profileService = ProfileService();

  MemberProvider() : super(const MemberState());

  // ============================================================
  // API CALLS
  // ============================================================
  Future<void> getProfile() async {
    if (state.apiGetMemberStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetMemberStatus: ApiStatus.loading,
        apiGetMemberMessage: '',
      ),
    );

    try {
      final result = await _profileService.getProfile();

      final data = result.data;
      if (data != null) {
        SecureStorageHelper.instance.saveKodeMember(data.kodemember);

        emit(
          state.copyWith(apiGetMemberStatus: ApiStatus.success, profile: data),
        );
      } else {
        emit(
          state.copyWith(
            apiGetMemberStatus: ApiStatus.failure,
            apiGetMemberMessage: result.message ?? 'Failed to get profile data',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET PROFILE: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetMemberStatus: ApiStatus.failure,
          apiGetMemberMessage: e.message,
        ),
      );
    }
  }

  Future<void> getProfileDetail() async {
    if (state.apiGetMemberDetailStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetMemberDetailStatus: ApiStatus.loading,
        apiGetMemberDetailMessage: '',
      ),
    );

    try {
      final result = await _profileService.getProfileDetail();

      var data = result.data;
      if (data != null) {

        var detailProf = data.data?.copyWith(
          nohp: data.nohp,
        );

        emit(
          state.copyWith(
            apiGetMemberDetailStatus: ApiStatus.success,
            profileDetail: detailProf,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiGetMemberDetailStatus: ApiStatus.failure,
            apiGetMemberDetailMessage:
                result.message ?? 'Failed to get profile detail data',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET PROFILE DETAIL: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetMemberDetailStatus: ApiStatus.failure,
          apiGetMemberDetailMessage: e.message,
        ),
      );
    }
  }

  Future<void> getProfileDevice() async {
    if (state.apiGetMemberDeviceStatus.isLoading) return;

    emit(
      state.copyWith(
        apiGetMemberDeviceStatus: ApiStatus.loading,
        apiGetMemberDeviceMessage: '',
      ),
    );

    try {
      final result = await _profileService.getProfileDevice();

      final data = result.data;
      if (data != null) {
        emit(
          state.copyWith(
            apiGetMemberDeviceStatus: ApiStatus.success,
            profileDeviceNumber: data.devices
                .where((device) => device.isNumber)
                .toList(),
            profileDevicePhone: data.devices
                .where((device) => !device.isNumber)
                .toList(),
          ),
        );

        getLokasiDevice();
      } else {
        emit(
          state.copyWith(
            apiGetMemberDeviceStatus: ApiStatus.failure,
            apiGetMemberDeviceMessage:
                result.message ?? 'Failed to get profile device data',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION GET PROFILE DEVICE: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGetMemberDeviceStatus: ApiStatus.failure,
          apiGetMemberDeviceMessage: e.message,
        ),
      );
    }
  }

  Future<void> logout() async {
    if (state.apiLogoutStatus.isLoading) return;

    emit(
      state.copyWith(apiLogoutStatus: ApiStatus.loading, apiLogoutMessage: ''),
    );

    try {
      final result = await _profileService.logout();

      if (!result.status) {
        emit(
          state.copyWith(
            apiLogoutStatus: ApiStatus.failure,
            apiLogoutMessage: result.message ?? 'Failed to logout',
          ),
        );

        showErrorMessage(result.message ?? 'Gagal logout dari aplikasi.');

        return;
      }

      SecureStorageHelper.instance.clearToken();
      pushNamedAndRemoveUntil(MainPage.routeName);

      emit(state.copyWith(apiLogoutStatus: ApiStatus.success));
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION LOGOUT: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiLogoutStatus: ApiStatus.failure,
          apiLogoutMessage: e.message,
        ),
      );
    }
  }

  Future<String> fetchLocationName(String lat, String lon) async {
    // Cek kosong dulu biar aman
    if (lat.isEmpty || lon.isEmpty) return '';

    final url = 'https://api.bigdatacloud.net/data/reverse-geocode-client';
    final dio = Dio();

    try {
      debugPrint('Mencari lokasi untuk lat: $lat, lon: $lon');

      final response = await dio.get(
        url,
        queryParameters: {
          'latitude': lat,
          'longitude': lon,
          'localityLanguage': 'id',
        },
      );

      final data = response.data;

      if (data != null) {
        final String city = data['city'] ?? '';
        String subdistrict = data['locality'] ?? '';

        // Logic fallback subdistrict
        if (subdistrict.isEmpty) {
          final localityInfo = data['localityInfo'];
          if (localityInfo != null &&
              localityInfo['administrative'] is List &&
              (localityInfo['administrative'] as List).isNotEmpty) {
            subdistrict = localityInfo['administrative'][0]['name'] ?? '';
          }
        }

        final String country = data['countryName'] ?? '';

        // Gabung string
        String fullLocation = '$city, $subdistrict, $country';

        // Rapihin koma
        fullLocation = fullLocation
            .replaceAll(RegExp(r'^,\s*|,\s*,|,\s*$'), '')
            .trim();

        debugPrint('Lokasi ditemukan: $fullLocation');

        // Return hasilnya
        return fullLocation;
      }
    } catch (e) {
      print('Gagal dapet lokasi: $e');
    }

    // Kalau gagal atau error, balikin string kosong
    return '';
  }

  void getLokasiDevice() async {
    if (state.profileDevicePhone.isEmpty) return;

    for (var i = 0; i < state.profileDevicePhone.length; i++) {
      final device = state.profileDevicePhone[i];
      final lat = device.lat;
      final long = device.long;

      if (lat != null && long != null) {
        final locationName = await fetchLocationName(lat, long);

        if (locationName.isNotEmpty) {
          final updatedDevice = device.copyWith(alamat: locationName);
          final updatedDevices = List<DeviceModel>.from(
            state.profileDevicePhone,
          );
          updatedDevices[i] = updatedDevice;

          emit(state.copyWith(profileDevicePhone: updatedDevices));
        }

        await Future.delayed(const Duration(milliseconds: 2000));
      }
    }

    for (var i = 0; i < state.profileDevicePhone.length; i++) {
      final device = state.profileDevicePhone[i];
      debugPrint('Device: ${device.device}, Alamat: ${device.alamat}');
    }
  }

  Future<bool> deleteDevice({
    required String perangkat,
    required String pintrx,
  }) async {
    if (state.apiDeleteMemberDeviceStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiDeleteMemberDeviceStatus: ApiStatus.loading,
        apiDeleteMemberDeviceMessage: '',
      ),
    );

    try {
      final result = await _profileService.deleteDevice(
        perangkat: perangkat,
        pintrx: pintrx,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiDeleteMemberDeviceStatus: ApiStatus.failure,
            apiDeleteMemberDeviceMessage:
                result.message ?? 'Failed to delete device',
          ),
        );

        showErrorMessage(result.message ?? 'Gagal menghapus perangkat.');

        return false;
      }

      emit(state.copyWith(apiDeleteMemberDeviceStatus: ApiStatus.success));

      // Refresh device list
      getProfileDevice();

      return true;
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION DELETE DEVICE: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiDeleteMemberDeviceStatus: ApiStatus.failure,
          apiDeleteMemberDeviceMessage: e.message,
        ),
      );

      return false;
    }
  }

  Future<bool> gantiPin({
    required String pinLama,
    required String pinBaru,
  }) async {
    if (state.apiGantiPinStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiGantiPinStatus: ApiStatus.loading,
        apiGantiPinMessage: '',
      ),
    );

    try {
      final result = await _profileService.gantiPin(
        pinlama: pinLama,
        pinbaru: pinBaru,
      );

      if (!result.status) {
        emit(
          state.copyWith(
            apiGantiPinStatus: ApiStatus.failure,
            apiGantiPinMessage: result.message ?? 'Failed to change PIN',
          ),
        );

        showErrorMessage(result.message ?? 'Gagal mengganti PIN.');

        return false;
      }

      emit(state.copyWith(apiGantiPinStatus: ApiStatus.success));

      showSuccessMessage('PIN berhasil diganti.');

      return true;
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION CHANGE PIN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiGantiPinStatus: ApiStatus.failure,
          apiGantiPinMessage: e.message,
        ),
      );

      return false;
    }
  }

  Future<bool> resetPin() async {
    if (state.apiResetPinStatus.isLoading) return false;

    emit(
      state.copyWith(
        apiResetPinStatus: ApiStatus.loading,
        apiResetPinMessage: '',
      ),
    );

    try {
      final result = await _profileService.resetPin();

      if (!result.status) {
        emit(
          state.copyWith(
            apiResetPinStatus: ApiStatus.failure,
            apiResetPinMessage: result.message ?? 'Failed to reset PIN',
          ),
        );

        showErrorMessage(result.message ?? 'Gagal mereset PIN.');

        return false;
      }

      emit(state.copyWith(apiResetPinStatus: ApiStatus.success));

      showSuccessMessage('PIN berhasil direset. Silakan cek email Anda.');

      return true;
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION RESET PIN: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiResetPinStatus: ApiStatus.failure,
          apiResetPinMessage: e.message,
        ),
      );

      return false;
    }
  }
}

MemberProvider getMemberProvider(BuildContext context) =>
    context.read<MemberProvider>();
