import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/widgets/card_product_voucher.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import 'aktivasi_voucher_provider.dart';
import 'widgets/input_tujuan_voucher.dart';

class GuestAkitvasiVoucherSatuanPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/aktivasi-voucher/satuan';

  const GuestAkitvasiVoucherSatuanPage({super.key});

  @override
  State<GuestAkitvasiVoucherSatuanPage> createState() =>
      _GuestAkitvasiVoucherSatuanPageState();
}

class _GuestAkitvasiVoucherSatuanPageState
    extends State<GuestAkitvasiVoucherSatuanPage> {
  void closePage() {
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
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
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
                        color: Colors.black.withValues(alpha: 0.1),
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
                      const Gap(6),
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
                      const Gap(5),
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
    final isButtonDisabled =
        state.listTujuan.isEmpty ||
        state.tujuanAkhirHasError ||
        state.tujuanAwalHasError;

    final backgroundColor = isButtonDisabled ? context.muted : context.primary;

    final foregroundColor = isButtonDisabled
        ? context.mutedForeground
        : context.primaryForeground;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: ()  {
          debugPrint("Lanjutkan Ke Pembelian Ditekan");
          var valid = getAktivasiVoucherProvider(
            context,
          ).validateMultiTujuan();

          if (!valid) {
            return;
          }
          BelumLoginDialog.show(context);
        },
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
                !isButtonDisabled
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

  Widget _buildFormInputTujuanVoucher(BuildContext context) {
    return BlocBuilder<AktivasiVoucherProvider, AktivasiVoucherState>(
      buildWhen: (oldState, newState) =>
          oldState.listTujuan != newState.listTujuan ||
          oldState.listTujuanHasError != newState.listTujuanHasError ||
          oldState.listTujuanErrorMessage != newState.listTujuanErrorMessage,
      builder: (context, state) {
        return Expanded(
          child: Card(
            child: Padding(
              padding: paddingCard,
              child: Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 6),
                      itemBuilder: (context, index) {
                        final tujuanVoucher = state.listTujuan[index];
                        final controller = state.listTujuanController[index];
                        final focusNode = state.listTujuanFocusNode[index];
                        final hasError = state.listTujuanHasError[index];
                        final errorMessage =
                            state.listTujuanErrorMessage[index];
                        final shakeKey = state.listTujuanShakeKey[index];

                        return InputTujuanVoucher(
                          label: "Tujuan Voucher ${index + 1}",
                          hintText: "Masukkan kode voucher",
                          controller: controller,
                          focusNode: focusNode,
                          hasError: hasError,
                          errorMessage: errorMessage,
                          shakeKey: shakeKey,
                          onChanged: (value) {
                            getAktivasiVoucherProvider(
                              context,
                            ).setMultiTujuan(index, value);
                          },
                          value: tujuanVoucher,
                          onClear: () {
                            getAktivasiVoucherProvider(
                              context,
                            ).setMultiTujuan(index, '', updateController: true);
                          },
                          // Tampilkan tombol hapus jika ada lebih dari 1 voucher
                          showDeleteButton: state.listTujuan.length > 1,
                          onDelete: () {
                            getAktivasiVoucherProvider(
                              context,
                            ).deleteMultiTujuan(index);
                          },
                        );
                      },
                      itemCount: state.listTujuan.length,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        text: "Tambah Voucher",
                        onPressed: () {
                          getAktivasiVoucherProvider(context).addMultiTujuan();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
            const Gap(5),
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
}
