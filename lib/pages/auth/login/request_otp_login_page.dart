import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/encrypt_helper.dart';
import 'package:dmpku/pages/auth/login/login_provider.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_button.dart';

class RequestOtpLoginPage extends StatefulWidget {
  static const routeName = '/auth/login/request-otp';

  const RequestOtpLoginPage({super.key});

  @override
  State<RequestOtpLoginPage> createState() => _RequestOtpLoginPageState();
}

class _RequestOtpLoginPageState extends State<RequestOtpLoginPage> {
  final _scrollController = ScrollController();
  final _phoneInputKey = GlobalKey();
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  void initState() {
    super.initState();
    getLoginProvider(
      context,
    ).state.phoneFocusNode?.addListener(_scrollToPhoneInput);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToPhoneInput() {
    if (!(getLoginProvider(context).state.phoneFocusNode?.hasFocus ?? false))
      return;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;

      final renderBox =
          _phoneInputKey.currentContext?.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final position = renderBox.localToGlobal(Offset.zero);
      final scrollOffset = _scrollController.offset + position.dy - 150;

      _scrollController.animateTo(
        scrollOffset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  void _onLogin() {
    var mdtest = EncryptHelper.md5Hash(
      input:
          "-7.9883485,112.5984481dmpku:95cdc59d49a9a5ab08815546178xs08815546178xudmpku:95cdc59d49a9a5abagung",
    );
    debugPrint("md5 test: $mdtest");

    getLoginProvider(context).state.phoneFocusNode?.unfocus();
    getLoginProvider(context).requestOtp();
  }

  void _onRegister() {
    // TODO: Implement register navigation
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlaDarkStyle(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            controller: _scrollController,
            padding: paddingPage.copyWith(left: 0, right: 0, bottom: 0),
            child: Column(children: [_buildHeader(), _buildContent(context)]),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Assets.img.logoText.image(height: 30, width: 130),
        Assets.img.imgLogin.image(width: double.infinity),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -115),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            _buildWelcomeText(context),
            const Gap(10),
            _buildDivider(context),
            const Gap(10),
            _buildPhoneInput(context),
            const Gap(10),
            _buildLoginButton(context),
            const Gap(10),
            _buildOtpHint(context),
            const Gap(5),
            _buildRegisterSection(context),
            const Gap(10),
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeText(BuildContext context) {
    return Column(
      children: [
        Text(
          'Semua Orang Bisa Usaha',
          style: context.pageTitle.withColor(context.primary),
        ),
        Text(
          'Nikmati kemudahan Isi Pulsa, Paket Data, Voucher Game, '
          'Token PLN, melalui smartphone Anda.',
          style: context.bodyMedium
              .withWeight(FontWeight.w400)
              .withColor(context.mutedForeground),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return BlocBuilder<LoginProvider, LoginState>(
      builder: (context, state) {
        return CustomButton(
          isLoading: state.apiRequestOtpStatus.isLoading,
          text: 'Masuk',
          height: 35,
          padding: const EdgeInsets.symmetric(vertical: 2),
          textStyle: context.bodyLarge
              .withColor(Colors.white)
              .withWeight(FontWeight.w600),
          onPressed: _onLogin,
          width: double.infinity,
        );
      },
    );
  }

  Widget _buildOtpHint(BuildContext context) {
    return Text(
      'Kode OTP untuk login akan dikirim ke nomor telepon melalui Whatsapp',
      style: context.bodySmall.withWeight(FontWeight.w600),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildRegisterSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildDivider(context)),
            Text(
              'Belum punya akun ?',
              style: context.bodyMedium
                  .withWeight(FontWeight.w400)
                  .withColor(context.mutedForeground),
              textAlign: TextAlign.center,
            ),
            Expanded(child: _buildDivider(context)),
          ],
        ),
        const Gap(10),
        CustomButton(
          text: 'Daftar',
          height: 35,
          variant: ButtonVariant.border,
          foregroundColor: context.primary,
          borderColor: context.primary,
          padding: const EdgeInsets.symmetric(vertical: 2),
          textStyle: context.bodyLarge
              .withColor(context.primary)
              .withWeight(FontWeight.w600),
          onPressed: _onRegister,
          width: double.infinity,
        ),
      ],
    );
  }

  Widget _buildFooter(BuildContext context) {
    return FutureBuilder<PackageInfo>(
      future: PackageInfo.fromPlatform(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final packageInfo = snapshot.data!;
        final textStyle = context.bodyMedium.withColor(context.mutedForeground);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Gap(8),
            Text('PT. DUNIA MASTER PULSA', style: textStyle),
            const Gap(2),
            Text(packageInfo.version, style: textStyle),
            const Gap(2),
            Text('Produk INDONESIA', style: textStyle),
            const Gap(15),
          ],
        );
      },
    );
  }

  Widget _buildDivider(BuildContext context) {
    return Container(
      height: 1,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: context.border,
        borderRadius: const BorderRadius.all(Radius.circular(0.5)),
      ),
    );
  }

  Widget _buildPhoneInput(BuildContext context) {
    return BlocBuilder<LoginProvider, LoginState>(
      builder: (context, state) {
        return Column(
          key: _phoneInputKey,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.muted,
                border: Border.all(
                  color: state.phoneHasError
                      ? context.destructive
                      : context.border,
                  width: 1,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(8)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                children: [
                  Assets.img.indonesianFlag.image(width: 25),
                  const Gap(8),
                  Text(
                    '+62',
                    style: context.bodyMedium
                        .withWeight(FontWeight.w500)
                        .withColor(context.foreground),
                  ),
                  const Gap(8),
                  Container(
                    width: 1,
                    height: 24,
                    decoration: BoxDecoration(
                      color: context.border,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(0.5),
                      ),
                    ),
                  ),
                  const Gap(8),
                  Expanded(child: _buildPhoneTextField(context, state)),
                ],
              ),
            ).withErrorShake(hasError: state.phoneHasError, key: shakeKey),

            if (state.phoneHasError)
              Padding(
                padding: const EdgeInsets.only(top: 6, left: 4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    state.phoneErrorMessage,
                    style: context.bodySmall
                        .withColor(context.destructive)
                        .withWeight(FontWeight.w500),
                  ),
                ),
              ),

            if (!state.otpResendDuration.isNegative)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Kirim ulang kode OTP dalam '
                    '${DateHelper.formatCountdownText(state.otpResendDuration)}',
                    textAlign: TextAlign.center,
                    style: context.bodySmall
                        .withColor(context.destructive)
                        .withWeight(FontWeight.w500),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildPhoneTextField(BuildContext context, LoginState state) {
    return TextField(
      controller: state.phoneController,
      focusNode: state.phoneFocusNode,
      keyboardType: TextInputType.phone,
      autofocus: true,
      style: context.bodyMedium.withColor(context.foreground),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(13),
      ],
      onChanged: (val) {
        getLoginProvider(context).setPhone(val);
      },
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintText: 'Contoh: 812XXXXXXXX',
        hintStyle: context.bodyMedium.withColor(context.mutedForeground),
        contentPadding: EdgeInsets.zero,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (_buildClearButton(context, state) != null)
              _buildClearButton(context, state)!,
            CustomPopupInputTujuan(
              isTempel: true,
              isContact: true,
              isVoice: true,
              onResult: (val) {
                getLoginProvider(context).setPhone(val, updateController: true);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget? _buildClearButton(BuildContext context, LoginState state) {
    if (state.phone.isEmpty) return null;

    return InkWell(
      onTap: () {
        getLoginProvider(context).setPhone('', updateController: true);
      },
      child: Icon(MdiIcons.close, size: 18, color: context.foreground),
    );
  }
}
