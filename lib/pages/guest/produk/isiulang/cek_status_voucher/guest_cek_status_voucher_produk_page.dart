import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/pages/guest/produk/isiulang/cek_status_voucher/cek_status_voucher_provider.dart';import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class GuestCekStatusVoucherProdukPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/cek-status-voucher/produk';

  const GuestCekStatusVoucherProdukPage({super.key});

  @override
  State<GuestCekStatusVoucherProdukPage> createState() =>
      _GuestCekStatusVoucherProdukPageState();
}

class _GuestCekStatusVoucherProdukPageState
    extends State<GuestCekStatusVoucherProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  void closePage() {
    getCekStatusVoucherProvider(context).resetProduct();
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
          appBar: CustomAppBar(
            title: getCekStatusVoucherProvider(
              context,
            ).state.selectedProduct.namaproduk,
            onBackButtonPressed: closePage,
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                _buildPhoneNumberCard(context),
                _buildDetailProvider(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberCard(BuildContext context) {
    return BlocBuilder<CekStatusVoucherProvider, CekStatusVoucherState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError,
      builder: (context, state) {
        return CardInputTujuan(
          tujuan: state.tujuan,
          label: 'Kode Voucher',
          hasError: state.tujuanHasError,
          errorMessage: state.tujuanErrorMessage,
          isEditable: true,
          hintText: 'Contoh : 1234XXXXXXXXXXX',
          controller: state.tujuanController,
          focusNode: state.tujuanFocusNode,
          onChanged: (value) {
            getCekStatusVoucherProvider(context).setTujuan(value);
          },
          onClear: () {
            getCekStatusVoucherProvider(
              context,
            ).setTujuan('', updateController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: true,
          addButtonLanjutkan: true,
          onLanjutkan: () {
            var valid = getCekStatusVoucherProvider(context).validateTujuan();
            if (!valid) {
              shakeKey.currentState?.shake();
            } else {
              BelumLoginDialog.show(context);
            }
          },
          labelButton: "Cek Status Voucher",
          isButtonDisabled: state.tujuanHasError,
          onFavoritResult: (val) {
            getCekStatusVoucherProvider(
              context,
            ).setTujuan(val, updateController: true);
          },
          icon: MdiIcons.ticket,
          suffixWidget: CustomPopupInputTujuan(
            isContact: true,
            isVoice: true,
            isTempel: true,
            onResult: (val) {
              getCekStatusVoucherProvider(
                context,
              ).setTujuan(val, updateController: true);
            },
          ),
        );
      },
    );
  }

  Widget _buildDetailProvider(BuildContext context) {
    return BlocBuilder<CekStatusVoucherProvider, CekStatusVoucherState>(
      buildWhen: (previous, current) =>
          previous.selectedProduct != current.selectedProduct,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CardProvider(
              imageUrl: state.selectedProduct.imgproduk,
              title: state.selectedProduct.namaproduk,
              subtitle: state.selectedProduct.deskripsiproduk,
              isGanti: false,
              onPressed: () {
                closePage();
              },
            ),
          ],
        );
      },
    );
  }
}
