import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/produk/ppob/e_samsat/member_e_samsat_provider.dart';
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

class MemberESamsatProdukPage extends StatefulWidget {
  static const routeName = '/member/produk/ppob/e-samsat/produk';

  const MemberESamsatProdukPage({super.key});

  @override
  State<MemberESamsatProdukPage> createState() =>
      _MemberESamsatProdukPageState();
}

class _MemberESamsatProdukPageState extends State<MemberESamsatProdukPage> {
  final _shakeKey = GlobalKey<ShakeErrorWidgetState>();
  final _shakeKeyNoMesin = GlobalKey<ShakeErrorWidgetState>();
  final _shakeKeyNik = GlobalKey<ShakeErrorWidgetState>();

  MemberESamsatProvider get _provider => getMemberESamsatProvider(context);

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
              children: [_buildIdAkunCard(context), _buildPlaceholder(context)],
            ),
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
              "Masukan Nomor Polisi",
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
    return BlocBuilder<MemberESamsatProvider, MemberESamsatState>(
      buildWhen: (previous, current) =>
          previous.selectedProduct != current.selectedProduct ||
          previous.tujuanHasError != current.tujuanErrorMessage ||
          previous.apiCekTagihanStatus != current.apiCekTagihanStatus ||
          previous.tujuan != current.tujuan ||
          previous.noMesin != current.noMesin ||
          previous.noMesinErrorMessage != current.noMesinErrorMessage ||
          previous.nik != current.nik ||
          previous.nikErrorMessage != current.nikErrorMessage ||
          previous.isJatim != current.isJatim,
      builder: (context, state) {
        var product = state.selectedProduct;

        return Card(
          child: Padding(
            padding: paddingCard,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    getMemberESamsatProvider(
                      context,
                    ).showPilihProdukDialog(context);
                  },
                ),
                Gap(8),
                Text(
                  "No. Polisi",
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
                if (state.isJatim) ...[
                  Text(
                    "No. Mesin",
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(8),
                  _buildTextFieldNoMesin(context, state),
                  if (state.noMesinHasError) ...[
                    const Gap(8),
                    Text(
                      state.noMesinErrorMessage,
                      style: context.bodySmall.withColor(context.destructive),
                    ),
                  ],
                  Text(
                    "NIk",
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(8),
                  _buildTextFieldNik(context, state),
                  if (state.nikHasError) ...[
                    const Gap(8),
                    Text(
                      state.noMesinErrorMessage,
                      style: context.bodySmall.withColor(context.destructive),
                    ),
                  ],
                  Gap(8),
                ],

                _buildCheckoutButton(context),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextFieldTujuan(BuildContext context, MemberESamsatState state) {
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
                hintText: "Contoh: N12345XX",
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

  Widget _buildTextFieldNoMesin(
    BuildContext context,
    MemberESamsatState state,
  ) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(
          color: state.noMesinHasError ? context.destructive : context.border,
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
              focusNode: state.noMesinFocusNode,
              controller: state.noMesinController,
              keyboardType: TipeInput.alphanumeric.keyboardType,
              inputFormatters: TipeInput.alphanumeric.inputFormatters,
              onChanged: (val) => _provider.setNoMesin(val),
              autofocus: false,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Contoh: SDF1234XXXXXXXX",
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.noMesin.isNotEmpty)
                      InkWell(
                        onTap: () =>
                            _provider.setNoMesin('', updateController: true),
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      ),
                    CustomPopupInputTujuan(
                      onResult: (val) =>
                          _provider.setNoMesin(val, updateController: true),
                      isTempel: true,
                      isVoice: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).withErrorShake(
      key: _shakeKeyNoMesin,
      hasError: state.noMesinHasError,
      onShakeComplete: () {},
    );
  }

  Widget _buildTextFieldNik(BuildContext context, MemberESamsatState state) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(
          color: state.nikHasError ? context.destructive : context.border,
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
              focusNode: state.nikFocusNode,
              controller: state.nikController,
              keyboardType: TipeInput.numericOnly.keyboardType,
              inputFormatters: TipeInput.numericOnly.inputFormatters,
              onChanged: (val) => _provider.setNIK(val),
              autofocus: false,
              decoration: InputDecoration(
                isDense: true,
                hintText: "Contoh: 1234XXXXXX",
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.nik.isNotEmpty)
                      InkWell(
                        onTap: () =>
                            _provider.setNIK('', updateController: true),
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      ),
                    CustomPopupInputTujuan(
                      onResult: (val) =>
                          _provider.setNIK(val, updateController: true),
                      isTempel: true,
                      isVoice: true,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).withErrorShake(
      key: _shakeKeyNik,
      hasError: state.nikHasError,
      onShakeComplete: () {},
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return BlocBuilder<MemberESamsatProvider, MemberESamsatState>(
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
