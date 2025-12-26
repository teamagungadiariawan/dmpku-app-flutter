import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_provider.dart';
import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/produk/button_cek_akun.dart';
import 'package:dmpku/widgets/produk/button_checkout.dart';
import 'package:dmpku/widgets/produk/button_favorit.dart';
import 'package:dmpku/widgets/produk/card_product.dart';
import 'package:dmpku/widgets/produk/card_product_pulsa_shimmer.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/produk/refreshable_list.dart';
import 'package:dmpku/widgets/produk/sort_filter_product.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class MemberDompetDigitalProdukNominalBebasPage extends StatefulWidget {
  static const String routeName =
      '/member/produk/ppob/dompet-digital/produk-nominal-bebas';

  const MemberDompetDigitalProdukNominalBebasPage({super.key});

  @override
  State<MemberDompetDigitalProdukNominalBebasPage> createState() =>
      _MemberDompetDigitalProdukkNominalBebasPageState();
}

class _MemberDompetDigitalProdukkNominalBebasPageState
    extends State<MemberDompetDigitalProdukNominalBebasPage> {
  final _shakeKey = GlobalKey<ShakeErrorWidgetState>();
  final _shakeKeyNominal = GlobalKey<ShakeErrorWidgetState>();

  MemberDompetDigitalProvider get _provider =>
      getMemberDompetDigitalProvider(context);

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
            child: Column(
              children: [
                _buildIdAkunCard(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Container(
                    padding: paddingCard,
                    decoration: BoxDecoration(
                      color: context.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: context.primary),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          MdiIcons.informationOutline,
                          size: 18,
                          color: context.primary,
                        ),
                        const Gap(6),
                        Expanded(
                          child: Text(
                            ' Pastikan Nomor tujuan dan Produk yang Anda pilih sudah sesuai jika terdapat kendala silahkan hubungi Customer Service 24 jam kami.',
                            style: context.bodySmall
                                .withColor(context.primary)
                                .withWeight(FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                _buildDetailProvider(),
                Gap(4),
                _buildCheckoutButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return BlocBuilder<MemberDompetDigitalProvider, MemberDompetDigitalState>(
      buildWhen: (prev, curr) =>
          prev.tujuan != curr.tujuan ||
          prev.tujuanHasError != curr.tujuanHasError ||
          prev.nominalTrx != curr.nominalTrx ||
          prev.nominalTrxHasError != curr.nominalTrxHasError ||
          prev.apiCekAkunStatus != curr.apiCekAkunStatus ||
          prev.selectedProduct != curr.selectedProduct,
      builder: (context, state) {
        return CustomButton(
          height: 35,
          isLoading: state.apiCekAkunStatus.isLoading,
          padding: EdgeInsets.zero,
          text: "Lanjutkan Ke Pembelian",
          width: double.infinity,
          onPressed: () {
            _provider.setNewKonfirmasiNominalBebas();
          },
          size: ButtonSize.large,
          state:
              (state.tujuanHasError ||
                  state.tujuan.isEmpty ||
                  state.nominalTrxHasError ||
                  state.nominalTrx.isEmpty ||
                  state.selectedProduct.idproduk == 0)
              ? ButtonState.disabled
              : ButtonState.enabled,
        );
      },
    );
  }

  Widget _buildIdAkunCard() {
    return BlocBuilder<MemberDompetDigitalProvider, MemberDompetDigitalState>(
      buildWhen: (prev, curr) =>
          prev.tujuan != curr.tujuan ||
          prev.tujuanHasError != curr.tujuanHasError ||
          prev.titleForm != curr.titleForm ||
          prev.hintForm != curr.hintForm ||
          prev.isCekAkun != curr.isCekAkun ||
          prev.selectedProvider != curr.selectedProvider ||
          prev.nominalTrx != curr.nominalTrx ||
          prev.nominalTrxHasError != curr.nominalTrxHasError,
      builder: (context, state) {
        return Card(
          child: Padding(
            padding: paddingCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.titleForm,
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(8),
                _buildTextFieldTujuan(context, state),
                if (state.tujuanHasError) ...[
                  const Gap(8),
                  Text(
                    state.tujuanErrorMessage,
                    style: context.bodySmall.withColor(context.destructive),
                  ),
                ],
                const Gap(8),
                ButtonFavorit(
                  isGuest: false,
                  onResult: (val) =>
                      _provider.setTujuan(val, updateController: true),
                ),
                const Gap(8),
                Text(
                  "Nominal",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(8),
                _buildTextFieldNominal(context, state),
                if (state.nominalTrxHasError) ...[
                  const Gap(8),
                  Text(
                    state.nominalTrxErrorMessage,
                    style: context.bodySmall.withColor(context.destructive),
                  ),
                ],
                const Gap(8),
                Text(
                  "Min. ${ToCurrency(state.selectedProduct.minnominalbebas.toString())} - Max. ${ToCurrency(state.selectedProduct.maxnominalbebas.toString())}",
                  style: context.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailProvider() {
    return BlocBuilder<MemberDompetDigitalProvider, MemberDompetDigitalState>(
      buildWhen: (prev, curr) => prev.selectedProduct != curr.selectedProduct,
      builder: (context, state) {
        return CardProvider(
          imageUrl: state.selectedProduct.imgproduk,
          title: state.selectedProduct.namaproduk,
          subtitle: state.selectedProduct.deskripsiproduk,
          isGanti: false,
          onPressed: closePage,
        );
      },
    );
  }

  Widget _buildTextFieldTujuan(
    BuildContext context,
    MemberDompetDigitalState state,
  ) {
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
          Icon(
            MdiIcons.cardAccountDetails,
            size: 18,
            color: context.foreground,
          ),
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
                hintText: state.hintForm,
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

  Widget _buildTextFieldNominal(
    BuildContext context,
    MemberDompetDigitalState state,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(
          color: state.nominalTrxHasError
              ? context.destructive
              : context.border,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(MdiIcons.cash, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: state.nominalTrxController,
              keyboardType: TipeInput.numericOnly.keyboardType,
              inputFormatters: TipeInput.numericOnly.inputFormatters,
              onChanged: (val) =>
                  _provider.setNominalTrx(val, updateController: true),
              autofocus: false,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Contoh : 1.000',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.nominalTrx.isNotEmpty)
                      InkWell(
                        onTap: () =>
                            _provider.setNominalTrx('', updateController: true),
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).withErrorShake(
      key: _shakeKeyNominal,
      hasError: state.nominalTrxHasError,
      onShakeComplete: () {},
    );
  }
}
