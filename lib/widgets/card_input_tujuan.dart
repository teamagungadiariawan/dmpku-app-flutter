import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/belum_login_dialog.dart';
import 'package:dmpku/widgets/produk/button_favorit.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class CardInputTujuan extends StatelessWidget {
  final String label;
  final String labelButton;
  final String tujuan;
  final bool hasError;
  final String errorMessage;
  final bool isEditable;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onLanjutkan;
  final Widget? suffixWidget;
  final GlobalKey<ShakeErrorWidgetState>? shakeKey;
  final bool showFavoritButton;
  final bool isGuest;
  final bool isCekAkun;
  final bool addButtonLanjutkan;
  final bool isButtonDisabled;
  final ValueChanged<String>? onFavoritResult;
  final IconData? icon;
  final TipeInput tipeInput;

  const CardInputTujuan({
    super.key,
    this.label = 'No. Tujuan',
    this.labelButton = 'Lanjutkan',
    required this.tujuan,
    this.hasError = false,
    this.errorMessage = '',
    this.isEditable = false,
    this.hintText = 'Contoh : 081XXXXXXXXX',
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onClear,
    this.onLanjutkan,
    this.suffixWidget,
    this.shakeKey,
    this.showFavoritButton = true,
    this.isGuest = false,
    this.isCekAkun = false,
    this.addButtonLanjutkan = false,
    this.isButtonDisabled = false,
    this.onFavoritResult,
    this.icon,
    this.tipeInput = TipeInput.numericOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: paddingCard,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
            ),
            const Gap(8),
            _buildInputField(context),
            if (hasError) ...[
              const Gap(8),
              Text(
                errorMessage,
                style: context.bodySmall.withColor(context.destructive),
              ),
            ],

            if (isCekAkun) ...[
              const Gap(8),
              CustomButton(
                text: "Cek Akun",
                onPressed: () {
                  if (isGuest) {
                    BelumLoginDialog.show(context);
                  }
                },
                height: 25,
                width: double.infinity,
                padding: EdgeInsets.zero,
              ),
            ],

            if (showFavoritButton) ...[
              const Gap(8),
              ButtonFavorit(
                isGuest: isGuest,
                onResult: onFavoritResult ?? (_) {},
              ),
            ],
            const Gap(5),
            if (addButtonLanjutkan)
              CustomButton(
                text: labelButton,
                width: double.infinity,
                onPressed: onLanjutkan,
                size: ButtonSize.large,
                state: isButtonDisabled
                    ? ButtonState.disabled
                    : ButtonState.enabled,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(BuildContext context) {
    final container = Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(
          color: hasError ? context.destructive : context.border,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(
            icon ?? MdiIcons.cardAccountDetails,
            size: 18,
            color: context.foreground,
          ),
          const Gap(6),
          Expanded(
            child: isEditable
                ? _buildTextField(context)
                : _buildDisplayText(context),
          ),
        ],
      ),
    );

    if (shakeKey != null) {
      return container.withErrorShake(
        key: shakeKey!,
        hasError: hasError,
        onShakeComplete: () {},
      );
    }

    return container;
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: tipeInput.keyboardType,
      inputFormatters: tipeInput.inputFormatters,
      onChanged: onChanged,
      autofocus: true,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        suffixIcon: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (tujuan.isNotEmpty && onClear != null)
              InkWell(
                onTap: onClear,
                child: Icon(
                  MdiIcons.close,
                  size: 18,
                  color: context.foreground,
                ),
              ),
            if (suffixWidget != null) suffixWidget!,
          ],
        ),
      ),
    );
  }

  Widget _buildDisplayText(BuildContext context) {
    return Text(
      tujuan.isEmpty ? hintText : tujuan,
      style: TextStyle(
        fontSize: 16,
        color: tujuan.isEmpty ? context.mutedForeground : null,
      ),
    );
  }
}
