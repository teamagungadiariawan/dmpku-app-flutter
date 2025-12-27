import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/keyboard_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_provider.dart';
import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

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
                _buildInfoCek(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCek(BuildContext context) {
    return BlocBuilder<MemberInfoKartuProvider, MemberInfoKartuState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError ||
          previous.apiCekAkunStatus != current.apiCekAkunStatus ||
          previous.cekAkunResult != current.cekAkunResult,
      builder: (context, state) {
        debugPrint("Cek akun result : ${state.cekAkunResult.items.length}");
        debugPrint(
          "cek tujuan : ${checkTujuanMatchResult(state.cekAkunResult, state.tujuan)}",
        );
        debugPrint("apiCekAkunStatus : ${state.apiCekAkunStatus.isSuccess}");

        if (state.cekAkunResult.items.isEmpty ||
            !checkTujuanMatchResult(state.cekAkunResult, state.tujuan) ||
            !state.apiCekAkunStatus.isSuccess) {
          return Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Gap(50),
                  Lottie.asset(Assets.animations.inputId, height: 200),
                  Gap(10),
                  Text(
                    "Masukan Kode Voucher",
                    style: context.bodyLarge
                        .withColor(context.primary)
                        .withWeight(FontWeight.w800),
                  ),
                ],
              ),
            ),
          );
        }

        return Card(
          child: Padding(
            padding: paddingCard,
            child: ListView.builder(
              itemCount: state.cekAkunResult.items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final item = state.cekAkunResult.items[index];
                return Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.key,
                        style: context.bodyMedium.withWeight(FontWeight.w600),
                      ),
                    ),
                    Text(
                      item.value,
                      style: context.bodyMedium.withWeight(FontWeight.w400),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneNumberCard(BuildContext context) {
    return BlocBuilder<MemberInfoKartuProvider, MemberInfoKartuState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
              previous.apiCekAkunStatus != current.apiCekAkunStatus ||
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
            getMemberInfoKartuProvider(
              context,
            ).setTujuan('', updateController: true);
          },
          shakeKey: shakeKey,
          showFavoritButton: false,
          isGuest: false,

          addButtonLanjutkan: true,
          onLanjutkan: () {
            var valid = getMemberInfoKartuProvider(context).validateTujuan();
            if (!valid) {
              shakeKey.currentState?.shake();
            } else {
              closeKeyBoard();
              getMemberInfoKartuProvider(
                context,
              ).cekInfoKartu();
            }
          },
          isLoadingCekAkun: state.apiCekAkunStatus.isLoading,
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
