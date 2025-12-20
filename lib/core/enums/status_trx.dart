import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

enum TrxStatus {
  pending,
  success,
  failed,
  expired,
  loading;

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
      case TrxStatus.loading:
        return 'Memuat...';
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
      case TrxStatus.loading:
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
      case TrxStatus.loading:
        return context.secondary.withOpacity(0.2);
    }
  }

  // 5. Property: BgColor Trx
  Color bgColorTrx(BuildContext context) {
    switch (this) {
      // Ganti dengan variable color lo, misal: AppColors.primary
      case TrxStatus.success:
        return context.primary;
      case TrxStatus.pending:
        return context.warning; // warning50
      case TrxStatus.failed:
        return context.destructive; // error50
      case TrxStatus.expired:
      case TrxStatus.loading:
        return context.secondary;
    }
  }

  IconData get icon {
    switch (this) {
      case TrxStatus.success:
        return LucideIcons.badgeCheck;
      case TrxStatus.pending:
        return LucideIcons.hourglass;
      case TrxStatus.failed:
        return LucideIcons.xCircle;
      case TrxStatus.expired:
      case TrxStatus.loading:
        return LucideIcons.hourglass;
    }
  }

  // 6. Property: Image Provider
  ImageProvider get imageProvider {
    switch (this) {
      case TrxStatus.success:
        return Assets.img.status.icStatusSukses.provider();
      case TrxStatus.pending:
        return Assets.img.status.icStatusPending.provider();
      case TrxStatus.failed:
        return Assets.img.status.icStatusGagal.provider();
      case TrxStatus.expired:
      case TrxStatus.loading:
        return Assets.img.status.icStatusPending.provider();
    }
  }

  bool get isSuccess => this == TrxStatus.success;

  bool get isPending => this == TrxStatus.pending;

  bool get isFailed => this == TrxStatus.failed;

  bool get isExpired => this == TrxStatus.expired;
}
