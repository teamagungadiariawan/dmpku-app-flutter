import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/produk/ppob/internet_tv/member_internet_tv_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/produk/button_favorit.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class MemberInternetTvProdukPage extends StatefulWidget {
  static const routeName = '/member/produk/ppob/internet-tv/produk';

  const MemberInternetTvProdukPage({super.key});

  @override
  State<MemberInternetTvProdukPage> createState() =>
      _MemberInternetTvProdukPageState();
}

class _MemberInternetTvProdukPageState extends State<MemberInternetTvProdukPage> {
  final _shakeKey = GlobalKey<ShakeErrorWidgetState>();

  MemberInternetTvProvider get _provider => getMemberInternetTvProvider(context);

  void closePage() {
    _provider.resetProduct();
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
            title: _provider.state.selectedProduct.namaproduk,
            onBackButtonPressed: closePage,
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(children: [_buildIdAkunCard(context), _buildPlaceholder(context)]),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
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
              "Masukan ID Pelanggan",
              style: context.bodyLarge
                  .withColor(context.primary)
                  .withWeight(FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIdAkunCard(BuildContext context) {
    return BlocBuilder<MemberInternetTvProvider, MemberInternetTvState>(
      buildWhen: (previous, current) =>
          previous.selectedProduct != current.selectedProduct ||
          previous.tujuanHasError != current.tujuanErrorMessage ||
          previous.apiCekTagihanStatus != current.apiCekTagihanStatus ||
          previous.tujuan != current.tujuan,
      builder: (context, state) {
        var product = state.selectedProduct;

        return Card(
          child: Padding(
            padding: paddingCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                   "ID Pelanggan",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(8),
                _buildTextFieldTujuan(context, state),
                if (state.tujuanHasError) ...[
                  const Gap(8),
                  Text(
                    state.tujuanErrorMessage,
                    style: context.bodySmall.withColor(context.destructive),
                  ),
                ],
                Gap(8),
                ButtonFavorit(
                  isGuest: false,
                  onResult: (val) =>
                      _provider.setTujuan(val, updateController: true),
                ),
                Gap(8),
                Text(
                  "Penyedia Layanan",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Gap(8),
                CardProvider(
                  title: product.namaproduk,
                  subtitle: product.deskripsiproduk,
                  imageUrl: product.imgproduk,
                  onPressed: () {
                    getMemberInternetTvProvider(
                      context,
                    ).showPilihProdukDialog(context);
                  },
                ),
                Gap(8),
                _buildCheckoutButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFieldTujuan(BuildContext context, MemberInternetTvState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(
          color: state.tujuanHasError ? context.destructive : context.border,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(MdiIcons.clipboardAccount, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              focusNode: state.tujuanFocusNode,
              controller: state.tujuanController,
              keyboardType: state.selectedProduct.inputTipe.keyboardType,
              inputFormatters: state.selectedProduct.inputTipe.inputFormatters,
              onChanged: (val) => _provider.setTujuan(val),
              autofocus: false,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Contoh: 1234XXXXXXX",
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.tujuan.isNotEmpty)
                      InkWell(
                        onTap: () =>
                            _provider.setTujuan('', updateController: true),
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      ),
                    CustomPopupInputTujuan(
                      onResult: (val) =>
                          _provider.setTujuan(val, updateController: true),
                      isTempel: true,
                      isVoice: true,
                      isContact: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).withErrorShake(
      key: _shakeKey,
      hasError: state.tujuanHasError,
      onShakeComplete: () {},
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return BlocBuilder<MemberInternetTvProvider, MemberInternetTvState>(
      buildWhen: (prev, curr) =>
      prev.tujuan != curr.tujuan ||
          prev.tujuanHasError != curr.tujuanHasError ||
          prev.apiCekTagihanStatus != curr.apiCekTagihanStatus ||
          prev.selectedProduct != curr.selectedProduct,
      builder: (context, state) {
        return CustomButton(
          height: 35,
          isLoading: state.apiCekTagihanStatus.isLoading,
          padding: EdgeInsets.zero,
          text: "Cek Tagihan",
          width: double.infinity,
          onPressed: () {
            _provider.cekTagihan(context);
          },
          size: ButtonSize.large,
          state:
          (state.tujuanHasError ||
              state.tujuan.isEmpty ||
              state.selectedProduct.idproduk == 0)
              ? ButtonState.disabled
              : ButtonState.enabled,
        );
      },
    );
  }
}
