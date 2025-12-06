import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
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

  const MemberState({
    this.apiGetMemberStatus = ApiStatus.initial,
    this.apiGetMemberMessage = '',
    this.profile = DEFAULT_PROFILE,

    this.apiLogoutStatus = ApiStatus.initial,
    this.apiLogoutMessage = '',
  });

  MemberState copyWith({
    ApiStatus? apiGetMemberStatus,
    String? apiGetMemberMessage,
    ProfileModel? profile,

    ApiStatus? apiLogoutStatus,
    String? apiLogoutMessage,
  }) {
    return MemberState(
      apiGetMemberStatus: apiGetMemberStatus ?? this.apiGetMemberStatus,
      apiGetMemberMessage: apiGetMemberMessage ?? this.apiGetMemberMessage,
      profile: profile ?? this.profile,

      apiLogoutStatus: apiLogoutStatus ?? this.apiLogoutStatus,
      apiLogoutMessage: apiLogoutMessage ?? this.apiLogoutMessage,
    );
  }

  @override
  List<Object?> get props => [
    apiGetMemberStatus,
    apiGetMemberMessage,
    profile,

    apiLogoutStatus,
    apiLogoutMessage,
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

  Future<void> logout() async {
    if (state.apiLogoutStatus.isLoading) return;

    emit(
      state.copyWith(apiLogoutStatus: ApiStatus.loading, apiLogoutMessage: ''),
    );

    try {
      final result = await _profileService.logout();

      SecureStorageHelper.instance.clearToken();
      pushNamedAndRemoveUntil(MainPage.routeName);
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
}

MemberProvider getMemberProvider(BuildContext context) =>
    context.read<MemberProvider>();
