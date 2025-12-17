import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';

enum TrxStatus {
  pending,
  success,
  failed,
  expired;

  // 1. Logic parsing dari integer (status ID) ke Enum
  factory TrxStatus.fromId(int id) {
    if (id == 3) return TrxStatus.success;
    if ([0, 1, 2].contains(id)) return TrxStatus.pending;
    if ([4, 5].contains(id)) return TrxStatus.failed;
    return TrxStatus.expired;
  }

  // 2. Property: Text Label
  String get text {
    switch (this) {
      case TrxStatus.success:
        return 'Sukses';
      case TrxStatus.pending:
        return 'Pending';
      case TrxStatus.failed:
        return 'Gagal';
      case TrxStatus.expired:
        return 'Expired';
    }
  }

  // 3. Property: Color
  Color textColor(BuildContext context) {
    switch (this) {
      // Ganti dengan variable color lo, misal: AppColors.primary
      case TrxStatus.success:
        return context.success;
      case TrxStatus.pending:
        return context.warning; // warning50
      case TrxStatus.failed:
        return context.destructive; // error50
      case TrxStatus.expired:
        return context.secondary;
    }
  }

  // 4. Property: BgColor
  Color bgColor(BuildContext context) {
    switch (this) {
      // Ganti dengan variable color lo, misal: AppColors.primary
      case TrxStatus.success:
        return context.success.withOpacity(0.2);
      case TrxStatus.pending:
        return context.warning.withOpacity(0.2); // warning50
      case TrxStatus.failed:
        return context.destructive.withOpacity(0.2); // error50
      case TrxStatus.expired:
        return context.secondary.withOpacity(0.2);
    }
  }
}
