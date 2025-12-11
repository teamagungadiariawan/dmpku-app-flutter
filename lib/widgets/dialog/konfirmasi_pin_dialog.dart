import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

/// Model untuk state transaksi sebelumnya
class TrxSebelumnyaState {
  final bool adaTrxSebelumnya;
  final KeyValueResponse detailTrxSebelumnya;

  const TrxSebelumnyaState({
    this.adaTrxSebelumnya = false,
    this.detailTrxSebelumnya = DEFAULT_KEY_VALUE_RESPONSE,
  });
}

class KonfirmasiPinDialog<B extends BlocBase<S>, S> extends StatefulWidget {
  final String title;
  final String subtitle;
  final String? titleTrxSebelumnya;
  final String? subtitleTrxSebelumnya;
  final Function(String pin) onConfirm;
  final B? bloc;
  final bool Function(S state)? isLoadingSelector;
  final String Function(S state)? errorMessageSelector;
  final TrxSebelumnyaState Function(S state)? trxSebelumnyaSelector;

  const KonfirmasiPinDialog({
    super.key,
    required this.title,
    required this.subtitle,
    this.titleTrxSebelumnya,
    this.subtitleTrxSebelumnya,
    required this.onConfirm,
    this.bloc,
    this.isLoadingSelector,
    this.errorMessageSelector,
    this.trxSebelumnyaSelector,
  });

  /// Show dialog dengan Bloc untuk loading state
  static void show<B extends BlocBase<S>, S>(
      BuildContext context, {
        required String title,
        required String subtitle,
        String? titleTrxSebelumnya,
        String? subtitleTrxSebelumnya,
        required Function(String pin) onConfirm,
        B? bloc,
        bool Function(S state)? isLoadingSelector,
        String Function(S state)? errorMessageSelector,
        TrxSebelumnyaState Function(S state)? trxSebelumnyaSelector,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      enableDrag: true,
      builder: (_) => bloc != null
          ? BlocProvider<B>.value(
        value: bloc,
        child: KonfirmasiPinDialog<B, S>(
          title: title,
          subtitle: subtitle,
          titleTrxSebelumnya: titleTrxSebelumnya,
          subtitleTrxSebelumnya: subtitleTrxSebelumnya,
          onConfirm: onConfirm,
          bloc: bloc,
          isLoadingSelector: isLoadingSelector,
          errorMessageSelector: errorMessageSelector,
          trxSebelumnyaSelector: trxSebelumnyaSelector,
        ),
      )
          : KonfirmasiPinDialog<B, S>(
        title: title,
        subtitle: subtitle,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<KonfirmasiPinDialog<B, S>> createState() =>
      _KonfirmasiPinDialogState<B, S>();
}

class _KonfirmasiPinDialogState<B extends BlocBase<S>, S>
    extends State<KonfirmasiPinDialog<B, S>> {
  String pin = "";
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  bool _previousTrxSebelumnya = false;

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void onComplete(String value) {
    setState(() => pin = value);
  }

  void onChanged(String value) {
    setState(() => pin = value);
  }

  /// Clear PIN input dan reset state
  void _clearPin() {
    pinController.clear();
    setState(() => pin = "");
    focusNode.requestFocus();
  }

  bool get isPinValid => pin.length == 6;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: context.pageTitle
          .withColor(context.primary)
          .withWeight(FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: context.primary),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.primary, width: 2),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: context.border, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const TopDividerSheet(),
              const Gap(15),
              _buildHeader(context),
              const Gap(5),
              _buildTrxSebelumnya(context),
              _buildErrorMessage(),
              _buildPinInput(
                context,
                defaultPinTheme,
                focusedPinTheme,
                submittedPinTheme,
              ),
              const Gap(10),
              _buildHintText(context),
              const Gap(15),
              _buildConfirmButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    if (widget.bloc != null && widget.trxSebelumnyaSelector != null) {
      return BlocSelector<B, S, TrxSebelumnyaState>(
        bloc: widget.bloc,
        selector: widget.trxSebelumnyaSelector!,
        builder: (context, trxState) {
          final title = trxState.adaTrxSebelumnya
              ? (widget.titleTrxSebelumnya ?? widget.title)
              : widget.title;
          final subtitle = trxState.adaTrxSebelumnya
              ? (widget.subtitleTrxSebelumnya ?? widget.subtitle)
              : widget.subtitle;

          return _buildHeaderCard(context, title, subtitle);
        },
      );
    }
    return _buildHeaderCard(context, widget.title, widget.subtitle);
  }

  Widget _buildHeaderCard(BuildContext context, String title, String subtitle) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.isDarkMode ? stone[700] : stone[100],
                shape: BoxShape.circle,
              ),
              child: const Icon(MdiIcons.lock),
            ),
            const Gap(10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(subtitle, style: context.bodySmall),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrxSebelumnya(BuildContext context) {
    if (widget.bloc != null && widget.trxSebelumnyaSelector != null) {
      return BlocSelector<B, S, TrxSebelumnyaState>(
        bloc: widget.bloc,
        selector: widget.trxSebelumnyaSelector!,
        builder: (context, trxState) {
          // Clear PIN ketika trx sebelumnya muncul (dari false ke true)
          if (trxState.adaTrxSebelumnya && !_previousTrxSebelumnya) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _clearPin();
            });
          }
          _previousTrxSebelumnya = trxState.adaTrxSebelumnya;

          if (!trxState.adaTrxSebelumnya) return const SizedBox.shrink();

          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Warning
                Text(
                  'Transaksi sudah dilakukan sebelumnya dengan data :',
                  style: context.bodySmall.copyWith(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Gap(10),

                // Detail List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: trxState.detailTrxSebelumnya.items.length,
                  separatorBuilder: (_, __) => const Gap(6),
                  itemBuilder: (context, index) {
                    final item = trxState.detailTrxSebelumnya.items[index];
                    final isStatus = item.key.toLowerCase() == 'status';
                    final isGagal = item.value.toLowerCase() == 'gagal';

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            item.key,
                            style: context.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            item.value,
                            style: context.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: isStatus
                                  ? (isGagal
                                  ? Colors.red.shade700
                                  : context.primary)
                                  : null,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const Gap(10),

                // Footer Warning
                Text(
                  'Untuk menghindari kesalahan transaksi, silahkan masukkan ulang PIN transaksi',
                  style: context.bodySmall.copyWith(
                    color: Colors.red.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildPinInput(
      BuildContext context,
      PinTheme defaultTheme,
      PinTheme focusedTheme,
      PinTheme submittedTheme,
      ) {
    return Align(
      alignment: Alignment.center,
      child: Pinput(
        controller: pinController,
        focusNode: focusNode,
        obscureText: true,
        length: 6,
        autofocus: true,
        defaultPinTheme: defaultTheme,
        focusedPinTheme: focusedTheme,
        submittedPinTheme: submittedTheme,
        pinputAutovalidateMode: PinputAutovalidateMode.disabled,
        showCursor: true,
        onCompleted: onComplete,
        onChanged: onChanged,
        closeKeyboardWhenCompleted: false,
      ),
    );
  }

  Widget _buildErrorMessage() {
    if (widget.bloc != null && widget.errorMessageSelector != null) {
      return BlocSelector<B, S, String>(
        bloc: widget.bloc,
        selector: widget.errorMessageSelector!,
        builder: (context, errorMessage) {
          if (errorMessage.isEmpty) return const SizedBox.shrink();

          return Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            margin: const EdgeInsets.symmetric(horizontal: 4).copyWith(bottom: 8,),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red.shade200),
            ),
            child: Row(
              children: [
                Icon(
                  MdiIcons.alertCircleOutline,
                  size: 18,
                  color: Colors.red.shade700,
                ),
                const Gap(8),
                Expanded(
                  child: Text(
                    errorMessage,
                    style: context.bodySmall.copyWith(
                      color: Colors.red.shade700,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildHintText(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          MdiIcons.checkboxMarkedCircleOutline,
          size: 25,
          color: context.primary,
        ),
        const Gap(5),
        Text(
          "Masukkan PIN untuk melanjutkan",
          style: context.bodyLarge.withColor(context.primary),
        ),
      ],
    );
  }

  Widget _buildConfirmButton() {
    if (widget.bloc != null && widget.isLoadingSelector != null) {
      return BlocSelector<B, S, bool>(
        bloc: widget.bloc,
        selector: widget.isLoadingSelector!,
        builder: (context, isLoading) => _buildButton(context, isLoading),
      );
    }
    return _buildButton(context, false);
  }

  Widget _buildButton(BuildContext context, bool isLoading) {
    return CustomButton(
      text: isLoading ? "Memproses..." : "Konfirmasi",
      onPressed:
      (isPinValid && !isLoading) ? () => widget.onConfirm(pin) : null,
      isLoading: isLoading,
      height: 40,
      size: ButtonSize.large,
      padding: EdgeInsets.zero,
      width: double.infinity,
    );
  }
}