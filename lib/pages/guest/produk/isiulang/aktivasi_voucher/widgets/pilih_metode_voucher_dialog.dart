import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/guest_akitvasi_voucher_berurutan_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/guest_akitvasi_voucher_satuan_page.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:dmpku/widgets/produk/card_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class PilihMetodeVoucherDialog extends StatelessWidget {
  const PilihMetodeVoucherDialog({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      requestFocus: true,
      useSafeArea: true,
      builder: (_) => const PilihMetodeVoucherDialog(),
    );
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopDividerSheet(),
              Gap(15),
              Card(
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.isDarkMode ? stone[700] : stone[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          MdiIcons.ticketPercentOutline,
                          color: context.foreground,
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pilih Metode Aktivasi Voucher',
                              style: context.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Pilih metode aktivasi voucher yang sesuai dengan kebutuhan Anda.',
                              style: context.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(6),
              CardProvider(
                title: 'Aktivasi Voucher Satuan',
                subtitle:
                    'Aktivasi voucher satuan ataupubn banyak dengan mudah',
                imageAsset: Assets.img.produk.icAkitviasiVoucherSatuan.path,
                isImgLocal: true,
                onPressed: () {
                  getAktivasiVoucherProvider(context).initMulti();
                  pushNamed(GuestAkitvasiVoucherSatuanPage.routeName);
                },
              ),
              Gap(6),
              CardProvider(
                title: 'Aktivasi Voucher Berurutan',
                subtitle: 'Aktivasi voucher berurutan dengan mudah dan cepat',
                imageAsset: Assets.img.produk.icAkitviasiVoucherBerurutan.path,
                isImgLocal: true,
                onPressed: () {
                  pushNamed(GuestAkitvasiVoucherBerurutanPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
