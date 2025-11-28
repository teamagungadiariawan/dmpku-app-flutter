import 'package:dmpku/core/apiconfig/server_exception.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/model/provider_response.dart';
import 'package:dmpku/service/guest/produk_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PulsaState extends Equatable {
  final ApiStatus apiFetchPulsaProviderStatus;
  final String apiFetchPulsaProviderMessage;
  final List<ProviderModel> pulsaProviders;

  final FocusNode? inputTujuanFocusNode;
  final bool hasErrorInputTujuan;
  final String errorMessageInputTujuan;
  final TextEditingController? inputTujuanController;
  final String tujuan;

  const PulsaState({
    this.apiFetchPulsaProviderStatus = ApiStatus.initial,
    this.apiFetchPulsaProviderMessage = '',
    this.pulsaProviders = const [],

    this.inputTujuanFocusNode,
    this.hasErrorInputTujuan = false,
    this.errorMessageInputTujuan = '',
    this.inputTujuanController,
    this.tujuan = '',
  });

  PulsaState copyWith({
    ApiStatus? apiFetchPulsaProviderStatus,
    String? apiFetchPulsaProviderMessage,
    List<ProviderModel>? pulsaProviders,

    FocusNode? inputTujuanFocusNode,
    bool? hasErrorInputTujuan,
    String? errorMessageInputTujuan,
    TextEditingController? inputTujuanController,
    String? tujuan,
  }) {
    return PulsaState(
      apiFetchPulsaProviderStatus:
          apiFetchPulsaProviderStatus ?? this.apiFetchPulsaProviderStatus,
      apiFetchPulsaProviderMessage:
          apiFetchPulsaProviderMessage ?? this.apiFetchPulsaProviderMessage,
      pulsaProviders: pulsaProviders ?? this.pulsaProviders,

      inputTujuanFocusNode: inputTujuanFocusNode ?? this.inputTujuanFocusNode,
      hasErrorInputTujuan: hasErrorInputTujuan ?? this.hasErrorInputTujuan,
      errorMessageInputTujuan:
          errorMessageInputTujuan ?? this.errorMessageInputTujuan,
      inputTujuanController:
          inputTujuanController ?? this.inputTujuanController,
      tujuan: tujuan ?? this.tujuan,
    );
  }

  @override
  List<Object?> get props => [
    apiFetchPulsaProviderStatus,
    apiFetchPulsaProviderMessage,
    pulsaProviders,

    inputTujuanFocusNode,
    hasErrorInputTujuan,
    errorMessageInputTujuan,
    inputTujuanController,
    tujuan,
  ];
}

class PulsaProvider extends Cubit<PulsaState> {
  final ProdukService _produkService = ProdukService();

  PulsaProvider()
    : super(
        PulsaState(
          inputTujuanFocusNode: FocusNode(),
          inputTujuanController: TextEditingController(),
        ),
      );

  void setTujuan(String tujuan,{
    bool updateTextController = false,
  }) {
    emit(
      state.copyWith(
        tujuan: tujuan,
      ),
    );

    if (updateTextController) {
      state.inputTujuanController?.text = tujuan;
      state.inputTujuanController?.selection = TextSelection.fromPosition(
        TextPosition(offset: tujuan.length),
      );
    }

    if (state.tujuan == '') {
      emit(
        state.copyWith(
          hasErrorInputTujuan: false,
          errorMessageInputTujuan: '',
        ),
      );
      return;
    }

    if (tujuan.length > 2) {
      validateTujuan();
    }
  }

  bool validateTujuan({ProviderModel selectedProvider = DEFAULT_PROVIDER})  {
    emit(
      state.copyWith(hasErrorInputTujuan: false, errorMessageInputTujuan: ''),
    );


    final tujuan = state.tujuan.trim();

    if (tujuan.isEmpty) {
      emit(
        state.copyWith(
          hasErrorInputTujuan: true,
          errorMessageInputTujuan: 'Tujuan tidak boleh kosong',
        ),
      );

      return false;
    } else {
      if (!tujuan.startsWith('08')) {
        emit(
          state.copyWith(
            hasErrorInputTujuan: true,
            errorMessageInputTujuan: 'Tujuan harus diawali dengan 08',
          ),
        );
        return false;
      }
    }

    if (selectedProvider.idprovider != 0) {
      final minLength = selectedProvider.mintujuan;
      final maxLength = selectedProvider.maxtujuan;

      if (tujuan.length < minLength || tujuan.length > maxLength) {
        emit(
          state.copyWith(
            hasErrorInputTujuan: true,
            errorMessageInputTujuan:
                'Panjang tujuan harus antara $minLength hingga $maxLength karakter',
          ),
        );
        return false;
      }

      final prefixList = selectedProvider.prefixList;
      var valid = false;
      for (var prefik in prefixList) {
        var maxRange = state.tujuan.length < prefik.length
            ? state.tujuan.length
            : prefik.length;

        if (prefik.startsWith(state.tujuan.substring(0, maxRange))) {
          valid = true;
          break;
        }
      }

      if (!valid) {
        emit(
          state.copyWith(
            hasErrorInputTujuan: true,
            errorMessageInputTujuan:
                'Tujuan tidak sesuai dengan prefix provider ${selectedProvider.namaprovider}',
          ),
        );
        return false;
      }
    }

    return true;
  }

  void resetState() {
    emit(
      PulsaState(
        inputTujuanFocusNode: FocusNode(),
        inputTujuanController: TextEditingController(),
        tujuan: '',
        apiFetchPulsaProviderStatus: ApiStatus.initial,
        pulsaProviders: [],
      ),
    );
  }

  void fetchPulsaProviders() async {
    if (state.apiFetchPulsaProviderStatus.isLoading) return;
    emit(
      state.copyWith(
        apiFetchPulsaProviderStatus: ApiStatus.loading,
        apiFetchPulsaProviderMessage: '',
      ),
    );

    try {
      final result = await _produkService.getPulsaGuestProviders();

      final data = result.data;

      if (data != null) {
        emit(
          state.copyWith(
            apiFetchPulsaProviderStatus: ApiStatus.success,
            pulsaProviders: data.providerList,
          ),
        );
      } else {
        emit(
          state.copyWith(
            apiFetchPulsaProviderStatus: ApiStatus.failure,
            apiFetchPulsaProviderMessage: 'Data provider pulsa kosong',
          ),
        );
      }
    } on ServerException catch (e) {
      debugPrint("SERVER EXCEPTION FETCH PULSA PROVIDERS: ${e.message}");

      showWarningMessage(e.message);
      emit(
        state.copyWith(
          apiFetchPulsaProviderStatus: ApiStatus.failure,
          apiFetchPulsaProviderMessage: e.message,
        ),
      );
    }
  }
}

PulsaProvider getPulsaProvider(BuildContext context) =>
    context.read<PulsaProvider>();
