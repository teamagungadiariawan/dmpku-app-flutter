import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class InputTujuanVoucher extends StatelessWidget {
  final String label;
  final bool hasError;
  final String errorMessage;
  final GlobalKey<ShakeErrorWidgetState> shakeKey;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String value;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;
  final TipeInput tipeInput;
  final String hintText;

  // Parameter baru untuk tombol hapus
  final bool showDeleteButton;
  final VoidCallback? onDelete;

  const InputTujuanVoucher({
    super.key,
    required this.label,
    required this.hasError,
    required this.errorMessage,
    required this.shakeKey,
    required this.value,
    required this.onChanged,
    required this.onClear,
    this.focusNode,
    this.controller,
    this.tipeInput = TipeInput.numericOnly,
    this.hintText = 'Masukkan nomor voucher',
    this.showDeleteButton = false,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: context.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        const Gap(8),
        _buildInputContainer(context),
        if (hasError) ...[
          const Gap(8),
          Text(
            errorMessage,
            style: context.bodySmall.withColor(context.destructive),
          ),
        ],
        const Gap(5),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return InkWell(
      onTap: onDelete,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: context.destructive.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(MdiIcons.trashCan, size: 20, color: context.destructive),
      ),
    );
  }

  Widget _buildInputContainer(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: context.muted,
              border: Border.all(
                color: hasError ? context.destructive : context.border,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.all(6),
            child: Row(
              children: [
                Icon(MdiIcons.ticket, size: 18, color: context.foreground),
                const Gap(6),
                Expanded(child: _buildTextField(context)),
              ],
            ),
          ).withErrorShake(
            key: shakeKey,
            hasError: hasError,
            onShakeComplete: () {},
          ),
        ),
        if (showDeleteButton && onDelete != null) ...[
          const Gap(8),
          _buildDeleteButton(context),
        ],
      ],
    );
  }

  Widget _buildTextField(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      controller: controller,
      keyboardType: tipeInput.keyboardType,
      inputFormatters: tipeInput.inputFormatters,
      onChanged: onChanged,
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        suffixIcon: _buildSuffixIcons(context),
      ),
    );
  }

  Widget _buildSuffixIcons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (value.isNotEmpty)
          InkWell(
            onTap: onClear,
            child: Icon(MdiIcons.close, size: 18, color: context.foreground),
          ),
        CustomPopupInputTujuan(
          onResult: onChanged,
          isScan: true,
          isTempel: true,
        ),
      ],
    );
  }
}