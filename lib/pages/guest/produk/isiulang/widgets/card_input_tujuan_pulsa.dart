import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/produk/button_favorit.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class CardInputTujuanPulsa extends StatelessWidget {
  final String label;
  final String tujuan;
  final bool hasError;
  final String errorMessage;
  final bool isEditable;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final Widget? suffixWidget;
  final GlobalKey<ShakeErrorWidgetState>? shakeKey;
  final bool showFavoritButton;
  final bool isGuest;
  final ValueChanged<String>? onFavoritResult;

  const CardInputTujuanPulsa({
    super.key,
    this.label = 'No. Tujuan',
    required this.tujuan,
    this.hasError = false,
    this.errorMessage = '',
    this.isEditable = false,
    this.hintText = 'Contoh : 081XXXXXXXXX',
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onClear,
    this.suffixWidget,
    this.shakeKey,
    this.showFavoritButton = true,
    this.isGuest = false,
    this.onFavoritResult,
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
            if (showFavoritButton) ...[
              const Gap(8),
              ButtonFavorit(
                isGuest: isGuest,
                onResult: onFavoritResult ?? (_) {},
              ),
            ],
            const Gap(5),
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
          Icon(MdiIcons.clipboardAccount, size: 18, color: context.foreground),
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
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: onChanged,
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
