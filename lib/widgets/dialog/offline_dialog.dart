import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class OfflineDialog extends StatelessWidget {
  final VoidCallback? onRetry;

  const OfflineDialog({super.key, this.onRetry});

  static void show(BuildContext context, {VoidCallback? onRetry}) {
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      enableDrag: false,
      builder: (_) => OfflineDialog(onRetry: onRetry),
    );
  }

  static void hide(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: context.border, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TopDividerSheet(),
              Gap(20),
              Lottie.asset(
                Assets.animations.noConnection,
                width: 300,
                fit: BoxFit.contain,
              ),
              Gap(15),
              Container(
                width: double.infinity,
                padding: paddingCard,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: context.primary, width: 1),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Gagal Koneksi Ke Server ${appname}",
                      style: context.bodyLarge.withWeight(FontWeight.w600),
                    ),
                    Gap(8),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(MdiIcons.starFourPointsSmall),
                        Gap(3),
                        Expanded(
                          child: Text(
                            "Periksa koneksi internet Anda dan coba lagi.",
                            style: context.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(MdiIcons.starFourPointsSmall),
                        Gap(3),
                        Expanded(
                          child: Text(
                            "Coba tutup aplikasi dan nyalakan mode pesawat selama 1-2 detik lalu matikan mode pesawat dan coba buka kembali aplikasi.",
                            style: context.bodySmall,
                          ),
                        ),
                      ],
                    ),
                    Gap(3),
                    Text(
                      "Jika masih gagal terhubung anda bisa menghubungi cs kami dengan link tombol di bawah.",
                      style: context.bodySmall
                          .withWeight(FontWeight.w300)
                          .withColor(context.mutedForeground),
                      textAlign: TextAlign.center,
                    ),
                    Gap(5),
                  ],
                ),
              ),
              Gap(5),
              CustomButton(
                height: 35,
                padding: EdgeInsets.zero,
                width: double.infinity,
                text: "Hubungi Kami",
                size: ButtonSize.large,
                icon: MdiIcons.whatsapp,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
