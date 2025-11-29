import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/product_response.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ButtonCheckout extends StatelessWidget {
  final ProductModel selectedProduct;
  final VoidCallback? onContinue;
  final bool isLoading;
  final bool isDisabled;

  const ButtonCheckout({
    super.key,
    required this.selectedProduct,
    this.onContinue,
    this.isLoading = false,
    this.isDisabled = false,
  });

  bool get _hasSelectedProduct => selectedProduct.idproduk != 0;

  bool get _isButtonDisabled => isDisabled || onContinue == null;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 8,
        bottom: 2 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: BoxDecoration(
        color: context.background,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10),
        ],
        border: Border(top: BorderSide(color: context.border, width: 1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(6),
          _buildSelectedProductInfo(context),
          const Gap(5),
          _buildContinueButton(context),
        ],
      ),
    );
  }

  Widget _buildSelectedProductInfo(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Gap(8),
        Text("Produk Terpilih : ", style: context.bodyMedium),
        Expanded(
          child: Text(
            _hasSelectedProduct ? selectedProduct.namaproduk : "-",
            textAlign: TextAlign.end,
            style: context.bodyMedium.withWeight(FontWeight.w600),
          ),
        ),
        const Gap(8),
      ],
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    final isDarkMode = context.isDarkMode;

    final backgroundColor = _isButtonDisabled
        ? (isDarkMode ? AppColors.darkMuted : AppColors.lightMuted)
        : context.primary;

    final foregroundColor = _isButtonDisabled
        ? (isDarkMode
              ? AppColors.darkMutedForeground
              : AppColors.lightMutedForeground)
        : context.primaryForeground;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading || _isButtonDisabled ? null : onContinue,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: backgroundColor,
          disabledForegroundColor: foregroundColor,
          padding: paddingCard.copyWith(top: 10, bottom: 10),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 14,
                width: 14,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(foregroundColor),
                ),
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Lanjutkan Ke Pembelian ",
                    style: context.bodyMedium.withColor(foregroundColor),
                  ),
                  Expanded(
                    child: Text(
                      _hasSelectedProduct
                          ? ToRupiah(selectedProduct.hargaproduk.toString())
                          : "-",
                      textAlign: TextAlign.end,
                      style: context.bodyMedium.withColor(foregroundColor),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
