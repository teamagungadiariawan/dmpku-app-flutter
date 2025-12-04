import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/auth/login/login_provider.dart';
import 'package:dmpku/pages/auth/widgets/warning_card.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/otp_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class VerifyOtpLoginPage extends StatefulWidget {
  static const routeName = '/auth/login/verify-otp';

  const VerifyOtpLoginPage({super.key});

  @override
  State<VerifyOtpLoginPage> createState() => _VerifyOtpLoginPageState();
}

class _VerifyOtpLoginPageState extends State<VerifyOtpLoginPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _closePage() {
    context.read<LoginProvider>().resetVerifyOtpState();
    pop();
  }

  void _resendOtp() {
    context.read<LoginProvider>().requestOtp(withPush: false);
  }

  void _verifyOtp() {
    context.read<LoginProvider>().verifyOtp();
  }

  void _openHelp() {
    // TODO: Implement help action
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlaDarkStyle(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) _closePage();
        },
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: paddingPage,
              child: Column(
                children: [
                  _buildBackButton(),
                  Expanded(child: _buildContent()),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackButton() {
    return Container(
      height: 40,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.white,
      child: InkWell(
        onTap: _closePage,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Icon(
              LucideIcons.chevronLeft400,
              color: context.foreground,
              size: 18,
            ),
            const Gap(5),
            Text(
              'Kembali',
              style: context.bodyLarge.copyWith(
                color: context.foreground,
                fontWeight: FontWeight.w400,
              ),
              textHeightBehavior: AppTextHeightBehavior.noPadding,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: paddingPage.copyWith(left: 0, right: 0, bottom: 0),
      child: Column(
        children: [
          _buildHeaderImage(),
          const Gap(40),
          _buildTitle(),
          const Gap(5),
          _buildSubtitle(),
          const Gap(30),
          _buildWarningCard(),
          const Gap(30),
          _buildOtpInput(),
        ],
      ),
    );
  }

  Widget _buildHeaderImage() {
    return Card(
      elevation: 6,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        child: Assets.img.lockVerifyOtp.image(
          fit: BoxFit.cover,
          width: 200,
          height: 200,
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Verifikasi OTP',
      style: context.pageTitle.withColor(context.foreground),
    );
  }

  Widget _buildSubtitle() {
    return BlocBuilder<LoginProvider, LoginState>(
      buildWhen: (prev, curr) => prev.phone != curr.phone,
      builder: (context, state) {
        return SizedBox(
          width: 350,
          child: Text.rich(
            TextSpan(
              style: context.bodyMedium
                  .withWeight(FontWeight.w500)
                  .withColor(context.mutedForeground),
              children: [
                const TextSpan(
                  text:
                      'Kami telah mengirimkan kode 6 digit via WhatsApp ke nomor ',
                ),
                TextSpan(
                  text: obfuscatePhone("0" + state.phone),
                  style: context.bodyMedium
                      .withWeight(FontWeight.w700)
                      .withColor(context.foreground),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }

  Widget _buildWarningCard() {
    return const SizedBox(
      width: 350,
      child: WarningCard(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        title: 'PENTING & RAHASIA',
        message:
            'Jangan berikan kode ini kepada siapapun, termasuk pihak yang mengaku dari bank atau aplikasi.',
        icon: MdiIcons.lock,
      ),
    );
  }

  Widget _buildOtpInput() {
    return OtpInput(
      spacing: 15,
      boxWidth: 40,
      onCompleted: (otp) => context.read<LoginProvider>().setOtp(otp),
    );
  }

  Widget _buildFooter() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Tidak menerima kode?',
          style: context.bodyMedium
              .withWeight(FontWeight.w500)
              .withColor(context.mutedForeground),
        ),
        const Gap(10),
        _buildResendButton(),
        const Gap(15),
        _buildVerifyButton(),
        const Gap(20),
        _buildHelpButton(),
        const Gap(40),
      ],
    );
  }

  Widget _buildResendButton() {
    return BlocBuilder<LoginProvider, LoginState>(
      buildWhen: (prev, curr) =>
          prev.otpResendDuration != curr.otpResendDuration,
      builder: (context, state) {
        final canResend = state.otpResendDuration.inSeconds < 0;
        final formattedTime =
            '${(state.otpResendDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(state.otpResendDuration.inSeconds % 60).toString().padLeft(2, '0')}';

        return GestureDetector(
          onTap: canResend ? _resendOtp : null,
          child: Container(
            padding: paddingCard,
            decoration: BoxDecoration(
              color: context.primary.withOpacity(canResend ? 0.25 : 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              canResend
                  ? 'Kirim ulang kode'
                  : 'Kirim ulang kode dalam $formattedTime',
              style: context.bodyMedium
                  .withWeight(FontWeight.w600)
                  .withColor(context.primary),
            ),
          ),
        );
      },
    );
  }

  Widget _buildVerifyButton() {
    return CustomButton(
      width: double.infinity,
      size: ButtonSize.large,
      iconPosition: IconPosition.end,
      icon: LucideIcons.arrowRight600,
      text: 'Verifikasi & Lanjutkan',
      textStyle: context.bodyLarge
          .withWeight(FontWeight.w600)
          .withColor(context.primaryForeground),
      onPressed: _verifyOtp,
    );
  }

  Widget _buildHelpButton() {
    return SizedBox(
      width: 150,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _openHelp,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.headset600, size: 16, color: context.primary),
            const Gap(5),
            Text(
              'Butuh Bantuan?',
              style: context.bodyMedium.withColor(context.primary),
            ),
          ],
        ),
      ),
    );
  }
}
