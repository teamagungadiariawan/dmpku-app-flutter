import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class CardPaketCuan extends StatelessWidget {
  final String? imageUrl;
  final String? imageAsset;
  final Widget? imageWidget;
  final String title;
  final String subtitle;
  final String buttonText;
  final Color? statusColor;
  final VoidCallback? onTap;
  final VoidCallback? onButtonPressed;
  final bool isImgLocal;
  final EdgeInsetsGeometry? margin;

  const CardPaketCuan({
    super.key,
    this.imageUrl,
    this.imageAsset,
    this.imageWidget,
    required this.title,
    required this.subtitle,
    this.buttonText = "Beli Disini",
    this.statusColor = Colors.white,
    this.onTap,
    this.onButtonPressed,
    this.isImgLocal = false,
    this.margin = const EdgeInsets.symmetric(vertical: 6),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: context.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.border, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Row(
          children: [
            _buildIconSection(context),
            if (statusColor != null) _buildStatusIndicator(),
            const SizedBox(width: 4),
            _buildTextSection(context),
            const SizedBox(width: 6),
            _buildButton(context),
            const SizedBox(width: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildIconSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      decoration: BoxDecoration(
        color: context.primary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          bottomLeft: Radius.circular(12),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: context.muted, shape: BoxShape.circle),
        child: _buildImage(context),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    if (imageWidget != null) {
      return imageWidget!;
    }

    if (isImgLocal && imageAsset != null) {
      return Image.asset(
        imageAsset!,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      );
    }

    if (imageUrl != null) {
      return Image.network(
        imageUrl!,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Icon(
            Icons.image_not_supported,
            size: 24,
            color: context.mutedForeground,
          );
        },
      );
    }

    return Icon(Icons.image, size: 24, color: context.mutedForeground);
  }

  Widget _buildStatusIndicator() {
    return Transform.translate(
      offset: const Offset(-5, 0),
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(shape: BoxShape.circle, color: statusColor),
      ),
    );
  }

  Widget _buildTextSection(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: context.labelLarge,
          ),
          Text(
            subtitle,
            style: context.bodySmall.copyWith(color: context.mutedForeground),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return CustomButton(
      text: "Beli Disini",
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10),
      variant: ButtonVariant.primary,
      onPressed: () {
        if (onButtonPressed != null) {
          onButtonPressed!();
        }
      },
    );
  }
}
