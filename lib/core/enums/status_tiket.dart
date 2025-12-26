import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';

enum StatusTiket {
  pending,
  sukses,
  expired;

  factory StatusTiket.fromId(int id) {
    if (id == 1) return StatusTiket.sukses;
    if (id == 0) return StatusTiket.pending;
    return StatusTiket.expired;
  }

  bool get isPending => this == StatusTiket.pending;

  bool get isSukses => this == StatusTiket.sukses;

  bool get isExpired => this == StatusTiket.expired;

  Color textColor(BuildContext context) {
    switch (this) {
      case StatusTiket.sukses:
        return context.primaryForeground;
      case StatusTiket.pending:
        return context.warningForeground;
      case StatusTiket.expired:
        return context.destructiveForeground;
    }
  }

  Color textColorSecondary(BuildContext context) {
    switch (this) {
      case StatusTiket.sukses:
        return context.primary;
      case StatusTiket.pending:
        return context.isDarkMode ? orange[300]! : orange[500]!;
      case StatusTiket.expired:
        return context.destructive;
    }
  }

  Color bgColor(BuildContext context) {
    switch (this) {
      case StatusTiket.sukses:
        return context.primary;
      case StatusTiket.pending:
        return context.warning;
      case StatusTiket.expired:
        return context.destructive;
    }
  }

  String get text {
    switch (this) {
      case StatusTiket.sukses:
        return 'Sukses';
      case StatusTiket.pending:
        return 'Pending';
      case StatusTiket.expired:
        return 'Expired';
    }
  }

  ButtonVariant get buttonVariant {
    switch (this) {
      case StatusTiket.sukses:
        return ButtonVariant.primary;
      case StatusTiket.pending:
        return ButtonVariant.warning;
      case StatusTiket.expired:
        return ButtonVariant.destructive;
    }
  }

  IconData get icon {
    switch (this) {
      case StatusTiket.sukses:
        return Icons.check_circle_outline;
      case StatusTiket.pending:
        return Icons.hourglass_top;
      case StatusTiket.expired:
        return Icons.cancel_outlined;
    }
  }

}
