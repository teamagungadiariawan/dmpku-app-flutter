import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  final _phoneController = TextEditingController();
  final _focusNode = FocusNode();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_scrollToBottomOnFocus);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _focusNode.removeListener(_scrollToBottomOnFocus);
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottomOnFocus() {
    if (!_focusNode.hasFocus) return;

    Future.delayed(const Duration(milliseconds: 300), () {
      if (!mounted) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    });
  }

  void _clearPhone() {
    _phoneController.clear();
    setState(() {});
  }

  void _onLogin() {
    // TODO: Implement login logic
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
    return CustomButton(
      text: 'Masuk',
      height: 35,
      padding: const EdgeInsets.symmetric(vertical: 2),
      textStyle: context.bodyLarge
          .withColor(Colors.white)
          .withWeight(FontWeight.w600),
      onPressed: _onLogin,
      width: double.infinity,
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border),
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
              borderRadius: const BorderRadius.all(Radius.circular(0.5)),
            ),
          ),
          const Gap(8),
          Expanded(child: _buildPhoneTextField(context)),
        ],
      ),
    );
  }

  Widget _buildPhoneTextField(BuildContext context) {
    return TextField(
      controller: _phoneController,
      focusNode: _focusNode,
      keyboardType: TextInputType.phone,
      autofocus: true,
      style: context.bodyMedium.withColor(context.foreground),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(13),
      ],
      onChanged: (_) => setState(() {}),
      decoration: InputDecoration(
        isDense: true,
        border: InputBorder.none,
        hintText: 'Contoh: 812XXXXXXXX',
        hintStyle: context.bodyMedium.withColor(context.mutedForeground),
        contentPadding: EdgeInsets.zero,
        suffixIcon: _buildClearButton(context),
      ),
    );
  }

  Widget? _buildClearButton(BuildContext context) {
    if (_phoneController.text.isEmpty) return null;

    return InkWell(
      onTap: _clearPhone,
      child: Icon(MdiIcons.close, size: 18, color: context.foreground),
    );
  }
}
