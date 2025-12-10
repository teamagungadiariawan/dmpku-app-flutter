import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/cek_status_voucher_provider.dart';import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

class MemberCekStatusVoucherProdukPage extends StatefulWidget {
  static const routeName = '/member/produk/isiulang/cek-status-voucher/produk';

  const MemberCekStatusVoucherProdukPage({super.key});

  @override
  State<MemberCekStatusVoucherProdukPage> createState() =>
      _MemberCekStatusVoucherProdukPageState();
}

class _MemberCekStatusVoucherProdukPageState
    extends State<MemberCekStatusVoucherProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  void closePage() {
    getMemberCekStatusVoucherProvider(context).resetProduct();
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
            title: getMemberCekStatusVoucherProvider(
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
    return BlocBuilder<MemberCekStatusVoucherProvider, MemberCekStatusVoucherState>(
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
            getMemberCekStatusVoucherProvider(context).setTujuan(value);
          },
          onClear: () {
            getMemberCekStatusVoucherProvider(
              context,
            ).setTujuan('', updateController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: false,
          addButtonLanjutkan: true,
          onLanjutkan: () {
            var valid = getMemberCekStatusVoucherProvider(context).validateTujuan();
            if (!valid) {
              shakeKey.currentState?.shake();
            } else {
              // TODO: Implement checkout
            }
          },
          labelButton: "Cek Status Voucher",
          isButtonDisabled: state.tujuanHasError,
          onFavoritResult: (val) {
            getMemberCekStatusVoucherProvider(
              context,
            ).setTujuan(val, updateController: true);
          },
          icon: MdiIcons.ticket,
          suffixWidget: CustomPopupInputTujuan(
            isContact: true,
            isVoice: true,
            isTempel: true,
            onResult: (val) {
              getMemberCekStatusVoucherProvider(
                context,
              ).setTujuan(val, updateController: true);
            },
          ),
        );
      },
    );
  }

  Widget _buildDetailProvider(BuildContext context) {
    return BlocBuilder<MemberCekStatusVoucherProvider, MemberCekStatusVoucherState>(
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
