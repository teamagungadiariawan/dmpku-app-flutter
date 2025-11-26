import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final ButtonSize size;
  final ButtonVariant variant;
  final ButtonState state;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;
  final String? tooltip;
  final int? badge;
  final BadgePosition badgePosition;

  final Color? foregroundColor;
  final Color? backgroundColor;

  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.size = ButtonSize.medium,
    this.variant = ButtonVariant.primary,
    this.state = ButtonState.enabled,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.tooltip,
    this.badge,
    this.badgePosition = BadgePosition.topRight,

    this.foregroundColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.isDarkMode;
    final (backgroundColor, foregroundColor, borderColor) = _getColors(
      context,
      isDarkMode,
    );
    final (paddingValue, fontSize) = _getSize();
    final isDisabled =
        widget.state == ButtonState.disabled || widget.onPressed == null;

    final button = SizedBox(
      width: widget.width,
      height: widget.height,
      child: ElevatedButton(
        onPressed: widget.isLoading || isDisabled ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isDisabled && !widget.isLoading
              ? (isDarkMode ? AppColors.darkMuted : AppColors.lightMuted)
              : backgroundColor,
          foregroundColor: foregroundColor,
          padding: widget.padding ?? paddingValue,
          shape: RoundedRectangleBorder(
            borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
            side: widget.variant == ButtonVariant.outline
                ? BorderSide(color: borderColor, width: 1.5)
                : BorderSide.none,
          ),
          elevation: 0,
          disabledBackgroundColor: isDisabled && !widget.isLoading
              ? (isDarkMode ? AppColors.darkMuted : AppColors.lightMuted)
              : backgroundColor,
          disabledForegroundColor: isDarkMode
              ? AppColors.darkMutedForeground
              : AppColors.lightMutedForeground,
        ),
        child: widget.isLoading
            ? SizedBox(
                height: fontSize,
                width: fontSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(foregroundColor),
                ),
              )
            : _buildButtonContent(fontSize, foregroundColor),
      ),
    );

    // Wrap with badge if badge is provided
    final buttonWithBadge = widget.badge != null && widget.badge! > 0
        ? _buildButtonWithBadge(button)
        : button;

    // Wrap with Tooltip if tooltip text is provided
    if (widget.tooltip != null && widget.tooltip!.isNotEmpty) {
      return Tooltip(message: widget.tooltip!, child: buttonWithBadge);
    }

    return buttonWithBadge;
  }

  Widget _buildButtonContent(double fontSize, Color foregroundColor) {
    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: fontSize),
          widget.text != '' ? SizedBox(width: 8) : SizedBox.shrink(),
          widget.text != ''
              ? Text(
                  widget.text,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600,
                  ),
                )
              : SizedBox.shrink(),
        ],
      );
    }

    return Text(
      widget.text,
      style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w600),
    );
  }

  Widget _buildButtonWithBadge(Widget button) {
    final badgeCount = widget.badge!;
    final badgeText = badgeCount > 99 ? '99+' : '$badgeCount';

    Alignment alignment;
    Offset offset;

    switch (widget.badgePosition) {
      case BadgePosition.topRight:
        alignment = Alignment.topRight;
        offset = const Offset(8, -8);
        break;
      case BadgePosition.topLeft:
        alignment = Alignment.topLeft;
        offset = const Offset(-8, -8);
        break;
      case BadgePosition.inline:
        // For inline, we don't use Stack
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            button,
            const SizedBox(width: 8),
            _buildBadgeContainer(badgeText),
          ],
        );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        button,
        Positioned(
          top: offset.dy,
          right: widget.badgePosition == BadgePosition.topRight
              ? offset.dx
              : null,
          left: widget.badgePosition == BadgePosition.topLeft
              ? offset.dx.abs()
              : null,
          child: _buildBadgeContainer(badgeText),
        ),
      ],
    );
  }

  Widget _buildBadgeContainer(String badgeText) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.4),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
      child: Center(
        child: Text(
          badgeText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  (Color backgroundColor, Color foregroundColor, Color borderColor) _getColors(
    BuildContext context,
    bool isDarkMode,
  ) {
    Color bgColor;
    Color fgColor;
    Color brColor;

    switch (widget.variant) {
      case ButtonVariant.primary:
        bgColor = isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
        fgColor = isDarkMode
            ? AppColors.darkPrimaryForeground
            : AppColors.lightPrimaryForeground;
        brColor = isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
        break;

      case ButtonVariant.secondary:
        bgColor = isDarkMode
            ? AppColors.darkSecondary
            : AppColors.lightSecondary;
        fgColor = isDarkMode
            ? AppColors.darkSecondaryForeground
            : AppColors.lightSecondaryForeground;
        brColor = isDarkMode
            ? AppColors.darkSecondary
            : AppColors.lightSecondary;
        break;

      case ButtonVariant.destructive:
        bgColor = isDarkMode
            ? AppColors.lightDestructive
            : AppColors.lightDestructive;
        fgColor = isDarkMode
            ? AppColors.lightDestructiveForeground
            : AppColors.lightDestructiveForeground;
        brColor = isDarkMode
            ? AppColors.lightDestructive
            : AppColors.lightDestructive;
        break;

      case ButtonVariant.outline:
        bgColor = Colors.transparent;
        fgColor = isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
        brColor = isDarkMode ? AppColors.darkPrimary : AppColors.lightPrimary;
        break;

      case ButtonVariant.ghost:
        bgColor = Colors.transparent;
        fgColor = isDarkMode
            ? AppColors.darkForeground
            : AppColors.lightForeground;
        brColor = Colors.transparent;
        break;
    }

    // Override dengan custom color jika diberikan
    return (
      widget.backgroundColor ?? bgColor,
      widget.foregroundColor ?? fgColor,
      widget.foregroundColor ?? brColor, // border color mengikuti foreground
    );
  }

  (EdgeInsetsGeometry padding, double fontSize) _getSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return (const EdgeInsets.symmetric(horizontal: 12, vertical: 8), 12);
      case ButtonSize.medium:
        return (const EdgeInsets.symmetric(horizontal: 16, vertical: 12), 14);
      case ButtonSize.large:
        return (const EdgeInsets.symmetric(horizontal: 20, vertical: 14), 16);
    }
  }
}

enum ButtonSize { small, medium, large }

enum ButtonVariant { primary, secondary, destructive, outline, ghost }

enum ButtonState { enabled, disabled, loading }

enum BadgePosition { topRight, topLeft, inline }
