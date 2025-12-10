import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/info_kartu_provider.dart';
import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MemberInfoKartuProdukPage extends StatefulWidget {
  static const routeName = '/member/produk/isiulang/info-kartu/produk';

  const MemberInfoKartuProdukPage({super.key});

  @override
  State<MemberInfoKartuProdukPage> createState() =>
      _MemberInfoKartuProdukPageState();
}

class _MemberInfoKartuProdukPageState extends State<MemberInfoKartuProdukPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  void closePage() {
    getMemberInfoKartuProvider(context).resetProduct();
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
            title: getMemberInfoKartuProvider(
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
    return BlocBuilder<MemberInfoKartuProvider, MemberInfoKartuState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError,
      builder: (context, state) {
        return CardInputTujuan(
          tujuan: state.tujuan,
          label: 'No. Tujuan',
          hasError: state.tujuanHasError,
          errorMessage: state.tujuanErrorMessage,
          isEditable: true,
          hintText: 'Contoh : 081XXXXXXXXX',
          controller: state.tujuanController,
          focusNode: state.tujuanFocusNode,
          onChanged: (value) {
            getMemberInfoKartuProvider(context).setTujuan(value);
          },
          onClear: () {
            getMemberInfoKartuProvider(context).setTujuan('', updateController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: true,
          isGuest: false,

          addButtonLanjutkan: true,
          onLanjutkan: () {
            var valid = getMemberInfoKartuProvider(context).validateTujuan();
            if (!valid) {
              shakeKey.currentState?.shake();
            } else {
              BelumLoginDialog.show(context);
            }
          },
          labelButton: "Cek Info Kartu",
          isButtonDisabled: state.tujuanHasError,
          onFavoritResult: (val) {
            getMemberInfoKartuProvider(
              context,
            ).setTujuan(val, updateController: true);
          },
          suffixWidget: CustomPopupInputTujuan(
            isContact: true,
            isVoice: true,
            isTempel: true,
            onResult: (val) {
              getMemberInfoKartuProvider(
                context,
              ).setTujuan(val, updateController: true);
            },
          ),
        );
      },
    );
  }

  Widget _buildDetailProvider(BuildContext context) {
    return BlocBuilder<MemberInfoKartuProvider, MemberInfoKartuState>(
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