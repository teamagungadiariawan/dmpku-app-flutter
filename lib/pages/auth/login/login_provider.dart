import 'dart:async';

import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/location_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/pages/auth/login/verify_otp_login_page.dart';
import 'package:dmpku/service/auth_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ============================================================
// STATE
// ============================================================
class LoginState extends Equatable {
  // Request OTP API
  final ApiStatus apiRequestOtpStatus;
  final String apiRequestOtpMessage;
  final String hashloginotp;
  final String location;

  // Request VERIFY OTP API
  final ApiStatus apiVerifyOtpStatus;
  final String apiVerifyOtpMessage;

  // Durasi
  final Duration otpResendDuration;

  // Phone
  final String phone;
  final bool phoneHasError;
  final String phoneErrorMessage;
  final TextEditingController? phoneController;
  final FocusNode? phoneFocusNode;

  // Otp
  final String otp;
  final bool otpHasError;
  final String otpErrorMessage;

  const LoginState({
    // Request OTP API
    this.apiRequestOtpStatus = ApiStatus.initial,
    this.apiRequestOtpMessage = '',
    this.hashloginotp = '',
    this.location = '',

    // Request VERIFY OTP API
    this.apiVerifyOtpStatus = ApiStatus.initial,
    this.apiVerifyOtpMessage = '',

    // Durasi
    this.otpResendDuration = const Duration(seconds: -1),

    // Phone
    this.phone = '',
    this.phoneHasError = false,
    this.phoneErrorMessage = '',
    this.phoneController,
    this.phoneFocusNode,

    // Otp
    this.otp = '',
    this.otpHasError = false,
    this.otpErrorMessage = '',
  });

  LoginState copyWith({
    ApiStatus? apiRequestOtpStatus,
    String? apiRequestOtpMessage,
    String? hashloginotp,
    String? location,
    ApiStatus? apiVerifyOtpStatus,
    String? apiVerifyOtpMessage,
    Duration? otpResendDuration,
    String? phone,
    bool? phoneHasError,
    String? phoneErrorMessage,
    TextEditingController? phoneController,
    FocusNode? phoneFocusNode,
    String? otp,
    bool? otpHasError,
    String? otpErrorMessage,
  }) {
    return LoginState(
      apiRequestOtpStatus: apiRequestOtpStatus ?? this.apiRequestOtpStatus,
      apiRequestOtpMessage: apiRequestOtpMessage ?? this.apiRequestOtpMessage,
      hashloginotp: hashloginotp ?? this.hashloginotp,
      location: location ?? this.location,
      apiVerifyOtpStatus: apiVerifyOtpStatus ?? this.apiVerifyOtpStatus,
      apiVerifyOtpMessage: apiVerifyOtpMessage ?? this.apiVerifyOtpMessage,
      otpResendDuration: otpResendDuration ?? this.otpResendDuration,
      phone: phone ?? this.phone,
      phoneHasError: phoneHasError ?? this.phoneHasError,
      phoneErrorMessage: phoneErrorMessage ?? this.phoneErrorMessage,
      phoneController: phoneController ?? this.phoneController,
      phoneFocusNode: phoneFocusNode ?? this.phoneFocusNode,
      otp: otp ?? this.otp,
      otpHasError: otpHasError ?? this.otpHasError,
      otpErrorMessage: otpErrorMessage ?? this.otpErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    apiRequestOtpStatus,
    apiRequestOtpMessage,
    hashloginotp,
    location,
    apiVerifyOtpStatus,
    apiVerifyOtpMessage,
    otpResendDuration,
    phone,
    phoneHasError,
    phoneErrorMessage,
    phoneController,
    phoneFocusNode,
    otp,
    otpHasError,
    otpErrorMessage,
  ];
}

// ============================================================
// CUBIT
// ============================================================

class LoginProvider extends Cubit<LoginState> {
  final AuthService _authService = AuthService();
  Timer? _otpCountdownTimer;

  LoginProvider()
    : super(
        LoginState(
          phoneController: TextEditingController(),
          phoneFocusNode: FocusNode(),
        ),
      );

  @override
  Future<void> close() {
    state.phoneController?.dispose();
    state.phoneFocusNode?.dispose();
    stopOtpCountdown();
    return super.close();
  }

  void resetVerifyOtpState() {
    emit(
      state.copyWith(
        hashloginotp: '',
        otp: '',
        otpHasError: false,
        otpErrorMessage: '',
      ),
    );
  }

  // ============================================================
  // COUNTDOWN TIMER
  // ============================================================

  void startOtpCountdown(Duration duration) {
    stopOtpCountdown();

    emit(state.copyWith(otpResendDuration: duration));

    _otpCountdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final remaining = state.otpResendDuration - const Duration(seconds: 1);

      debugPrint(
        "OTP RESEND DURATION: ${remaining.inSeconds} seconds remaining",
      );

      if (remaining.isNegative || remaining == Duration.zero) {
        stopOtpCountdown();
        emit(state.copyWith(otpResendDuration: const Duration(seconds: -1)));
      } else {
        emit(state.copyWith(otpResendDuration: remaining));
      }
    });
  }

  void stopOtpCountdown() {
    _otpCountdownTimer?.cancel();
    _otpCountdownTimer = null;
  }

  // ============================================================
  // API CALLS
  // ============================================================

  Future<void> requestOtp({bool withPush = true}) async {
    if (!validatePhone()) {
      return;
    }

    emit(
      state.copyWith(
        apiRequestOtpStatus: ApiStatus.loading,
        apiRequestOtpMessage: '',
      ),
    );

    try {
      var loc = await getLocation();
      emit(state.copyWith(location: loc));

      final result = await _authService.reqOtpLogin(
        nohpmember: "0" + state.phone.trim(),
        loc: loc,
      );

      if (result.status) {
        final duration = DateHelper.countdownFromString(result.durasi);

        emit(state.copyWith(hashloginotp: result.hashloginotp ?? ''));

        // Start countdown timer
        startOtpCountdown(duration!);
        if (withPush) {
          pushNamed(VerifyOtpLoginPage.routeName);
        }
      } else {
        stopOtpCountdown();
      }

      emit(
        state.copyWith(
          apiRequestOtpStatus: ApiStatus.success,
          apiRequestOtpMessage: 'OTP berhasil dikirim ke nomor Anda.',
        ),
      );
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION REQUEST OTP: ${e.message}");
      showWarningMessage(e.message);
      stopOtpCountdown();
      emit(
        state.copyWith(
          apiRequestOtpStatus: ApiStatus.failure,
          apiRequestOtpMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiRequestOtpStatus: ApiStatus.failure,
          apiRequestOtpMessage: 'Gagal mengirim OTP. Silakan coba lagi.',
        ),
      );
    }
  }

  Future<void> verifyOtp() async {
    if (!validateOtp()) {
      return;
    }

    emit(
      state.copyWith(
        apiVerifyOtpStatus: ApiStatus.loading,
        apiVerifyOtpMessage: '',
      ),
    );

    try {
      final result = await _authService.verOtpLogin(
        nohpmember: "0" + state.phone.trim(),
        otp: state.otp.trim(),
        hashloginotp: state.hashloginotp,
        loc: state.location,
      );

      if (result.status) {
        SecureStorageHelper.instance.write(
          StorageKeys.signmember,
          result.signmember,
        );
        SecureStorageHelper.instance.write(StorageKeys.token, result.token);
        SecureStorageHelper.instance.write(
          StorageKeys.refreshToken,
          result.refresh,
        );
      }

      emit(
        state.copyWith(
          apiVerifyOtpStatus: ApiStatus.success,
          apiVerifyOtpMessage: 'OTP berhasil diverifikasi.',
        ),
      );
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION VERIFY OTP: ${e.message}");
      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiVerifyOtpStatus: ApiStatus.failure,
          apiVerifyOtpMessage: e.message,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          apiVerifyOtpStatus: ApiStatus.failure,
          apiVerifyOtpMessage: 'Gagal memverifikasi OTP. Silakan coba lagi.',
        ),
      );
    }
  }

  // ============================================================
  // SETTERS
  // ============================================================

  void setPhone(String phone, {bool updateController = false}) {
    var fixPhone = phone;

    if (phone.startsWith("08")) {
      fixPhone = phone.substring(1);
    }

    if (phone.startsWith("62")) {
      fixPhone = phone.substring(2);
    }

    emit(state.copyWith(phone: fixPhone));
    if (updateController) {
      _updateController(state.phoneController, fixPhone);
    }

    validatePhone();
  }

  void setOtp(String otp) {
    emit(state.copyWith(otp: otp));
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }

  // ============================================================
  // VALIDATION
  // ============================================================

  bool validatePhone() {
    emit(state.copyWith(phoneHasError: false, phoneErrorMessage: ''));

    final error = _validatePhoneValue("0" + state.phone.trim());

    emit(
      state.copyWith(
        phoneHasError: error != null,
        phoneErrorMessage: error ?? '',
      ),
    );

    return error == null;
  }

  bool validateOtp() {
    emit(state.copyWith(otpHasError: false, otpErrorMessage: ''));

    if (state.otp.isEmpty) {
      emit(
        state.copyWith(
          otpHasError: true,
          otpErrorMessage: 'OTP tidak boleh kosong',
        ),
      );
      return false;
    }

    if (state.otp.length != 6) {
      emit(
        state.copyWith(
          otpHasError: true,
          otpErrorMessage: 'OTP harus terdiri dari 6 digit',
        ),
      );
      return false;
    }

    return true;
  }

  // ============================================================
  // PRIVATE VALIDATION HELPER
  // ============================================================

  String? _validatePhoneValue(String value) {
    if (value.isEmpty) {
      return 'Nomor telepon tidak boleh kosong';
    }

    final regex = RegExp(r'^[0-9]+$');
    if (!regex.hasMatch(value)) {
      return 'Nomor telepon hanya boleh berisi angka';
    }

    if (value.length < 9 || value.length > 13) {
      return 'Nomor telepon harus antara 9 hingga 13 digit';
    }

    var validTipeInput = TipeInput.numericOnly.isValid(value);
    if (!validTipeInput) {
      return TipeInput.numericOnly.errorMessage;
    }

    return null;
  }
}

LoginProvider getLoginProvider(BuildContext context) =>
    context.read<LoginProvider>();
