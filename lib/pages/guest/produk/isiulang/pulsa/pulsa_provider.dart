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

  void setTujuan(String tujuan) {
    emit(
      state.copyWith(
        tujuan: tujuan,
        inputTujuanController: state.inputTujuanController?..text = tujuan,
      ),
    );
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
