import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/widgets/card_product_voucher.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'widgets/input_tujuan_voucher.dart';

class GuestAkitvasiVoucherBerurutanPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/aktivasi-voucher/berurutan';

  const GuestAkitvasiVoucherBerurutanPage({super.key});

  @override
  State<GuestAkitvasiVoucherBerurutanPage> createState() =>
      _GuestAkitvasiVoucherBerurutanPageState();
}

class _GuestAkitvasiVoucherBerurutanPageState
    extends State<GuestAkitvasiVoucherBerurutanPage> {
  final shakeKeyAwal = GlobalKey<ShakeErrorWidgetState>();
  final shakeKeyAkhir = GlobalKey<ShakeErrorWidgetState>();

  void closePage() {
    getAktivasiVoucherProvider(context).resetBerurutan();
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: WillPopScope(
        onWillPop: () async {
          debugPrint("WillPopScope: onWillPop");
          closePage();
          return true; // true = izinkan pop
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false, // Tambahkan ini
          appBar: CustomAppBar(
            title: getAktivasiVoucherProvider(
              context,
            ).state.selectedProduct.namaproduk,
            onBackButtonPressed: closePage,
          ),
          body: Padding(
            padding: paddingPage,
            child: BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
              buildWhen: (previous, current) =>
                  previous.selectedProduct != current.selectedProduct,
              builder: (context, state) {
                return Column(
                  children: [
                    CardProductVoucher(product: state.selectedProduct),
                    _buildWarningMaxVoucher(context),
                    Expanded(child: _buildFormInputTujuanVoucher(context)),
                    Gap(40),
                  ],
                );
              },
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
              buildWhen: (previous, current) =>
                  previous.listTujuan != current.listTujuan ||
                  previous.tujuanAkhirHasError != current.tujuanAkhirHasError ||
                  previous.tujuanAwalHasError != current.tujuanAwalHasError ||
                  previous.selectedProduct != current.selectedProduct,
              builder: (context, state) {
                debugPrint("Rebuild Bottom Navigation Bar");
                debugPrint("Jumlah Voucher: ${state.listTujuan.length}");

                return Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 8,
                    bottom: 2 + MediaQuery.paddingOf(context).bottom,
                  ),
                  decoration: BoxDecoration(
                    color: context.background,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                      ),
                    ],
                    border: Border(
                      top: BorderSide(color: context.border, width: 1),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Gap(6),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Gap(8),
                          Text("Total Voucher : ", style: context.bodyMedium),
                          Expanded(
                            child: Text(
                              state.listTujuan.length.toString(),
                              textAlign: TextAlign.end,
                              style: context.bodyMedium.withWeight(
                                FontWeight.w600,
                              ),
                            ),
                          ),
                          const Gap(8),
                        ],
                      ),
                      Gap(5),
                      _buildContinueButton(context, state),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContinueButton(
    BuildContext context,
    AktivasiVoucherState state,
  ) {
    final _isButtonDisabled =
        state.listTujuan.isEmpty ||
        state.tujuanAkhirHasError ||
        state.tujuanAwalHasError;

    final backgroundColor = _isButtonDisabled ? context.muted : context.primary;

    final foregroundColor = _isButtonDisabled
        ? context.mutedForeground
        : context.primaryForeground;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => BelumLoginDialog.show(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: foregroundColor,
          padding: paddingCard.copyWith(top: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Lanjutkan Ke Pembelian ",
              style: context.bodyMedium.withColor(foregroundColor),
            ),
            Expanded(
              child: Text(
                !_isButtonDisabled
                    ? ToRupiah(
                        (state.listTujuan.length *
                                state.selectedProduct.hargaproduk)
                            .toString(),
                      )
                    : "-",
                textAlign: TextAlign.end,
                style: context.bodyMedium.withColor(foregroundColor),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningMaxVoucher(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: context.warning),
      ),
      color: context.warning,
      child: Padding(
        padding: paddingCard,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.warning_amber_rounded, color: Colors.white),
            Gap(5),
            Expanded(
              child: Text(
                'Maksimal Jumlah Aktivasi Voucher 10.',
                textHeightBehavior: AppTextHeightBehavior.noPadding,
                style: context.bodyLarge
                    .withColor(Colors.white)
                    .withWeight(FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormInputTujuanVoucher(BuildContext context) {
    return BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
      buildWhen: (oldState, newState) =>
          oldState.tujuanAwal != newState.tujuanAwal ||
          oldState.tujuanAkhir != newState.tujuanAkhir ||
          oldState.tujuanAwalHasError != newState.tujuanAwalHasError ||
          oldState.tujuanAkhirHasError != newState.tujuanAkhirHasError,
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: paddingCard,
            child: Column(
              children: [
                InputTujuanVoucher(
                  label: "Kode Voucher Awal",
                  tipeInput: state.selectedProvider.inputTipe,
                  hasError: state.tujuanAwalHasError,
                  errorMessage: state.tujuanAwalErrorMessage,
                  shakeKey: shakeKeyAwal,
                  focusNode: state.tujuanAwalFocusNode,
                  controller: state.tujuanAwalController,
                  onChanged: (value) {
                    getAktivasiVoucherProvider(context).setTujuanAwal(value);
                  },
                  value: state.tujuanAwal,
                  onClear: () {
                    getAktivasiVoucherProvider(
                      context,
                    ).setTujuanAwal('', updateController: true);
                  },
                ),
                Gap(6),
                InputTujuanVoucher(
                  label: "Kode Voucher Akhir",
                  tipeInput: state.selectedProvider.inputTipe,
                  hasError: state.tujuanAkhirHasError,
                  errorMessage: state.tujuanAkhirErrorMessage,
                  shakeKey: shakeKeyAkhir,
                  focusNode: state.tujuanAkhirFocusNode,
                  controller: state.tujuanAkhirController,
                  onChanged: (value) {
                    getAktivasiVoucherProvider(context).setTujuanAkhir(value);
                  },
                  value: state.tujuanAkhir,
                  onClear: () {
                    getAktivasiVoucherProvider(
                      context,
                    ).setTujuanAkhir('', updateController: true);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
