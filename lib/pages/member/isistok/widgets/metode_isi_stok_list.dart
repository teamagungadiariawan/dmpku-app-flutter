import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/isistok/alfamart/buat_tiket_alfamart_page.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/buat_tiket_bank_transfer_page.dart';
import 'package:dmpku/pages/member/isistok/indomaret/buat_tiket_indomaret_page.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/isistok/qris/buat_tiket_qris_page.dart';
import 'package:dmpku/pages/member/isistok/va/buat_tiket_va_page.dart';
import 'package:dmpku/pages/member/isistok/widgets/payment_method_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class MetodeIsiStokList extends StatelessWidget {
  const MetodeIsiStokList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      children: [
        Text(
          "Metode Isi Stok",
          style: context.bodyLarge.withWeight(FontWeight.w600),
        ),
        const Gap(5),
        PaymentMethodItem(
          image: Assets.img.stok.icSaldoTf.image(width: 45, height: 45),
          title: 'Bank Transfer',
          onTap: () {
            getMemberIsiStokProvider(context).fetchListBankTransfer();
            pushNamed(BuatTiketBankTransferPage.routeName);
          },
          titleBadge: Container(
            decoration: BoxDecoration(
              color: context.primary.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Text(
              "Tambahan kode unik",
              style: context.captionRegular
                  .withColor(context.primary)
                  .withWeight(FontWeight.w600),
            ),
          ),
          details: [
            DetailInfo(
              icon: MdiIcons.clockTimeFiveOutline,
              text: '05:00 - 21:00 WIB',
              iconColor: context.mutedForeground,
            ),
            const Gap(2),
            DetailInfo(
              icon: MdiIcons.progressClock,
              text: 'Pengisian saldo 1-10 menit',
              iconColor: context.primary,
              textColor: context.primary,
            ),
          ],
        ),
        const Gap(2),
        PaymentMethodItem(
          image: Assets.img.stok.icSaldoAlfa.image(width: 45, height: 45),
          title: 'Gerai Alfamart',
          subtitle: 'Biaya Admin 3.000',
          onTap: () {
            pushNamed(BuatTiketAlfamartPage.routeName);
          },
          details: [
            DetailInfo(
              icon: MdiIcons.lightningBoltOutline,
              text: '24 JAM',
              iconColor: context.primary,
              textColor: context.primary,
            ),
          ],
        ),
        const Gap(2),
        PaymentMethodItem(
          image: Assets.img.stok.icSaldoIndomaret.image(width: 45, height: 45),
          title: 'Gerai Indomaret',
          subtitle: 'Biaya Admin 3.500',
          onTap: () {
            pushNamed(BuatTiketIndomaretPage.routeName);
          },
          details: [
            DetailInfo(
              icon: MdiIcons.lightningBoltOutline,
              text: '24 JAM',
              iconColor: context.primary,
              textColor: context.primary,
            ),
          ],
        ),
        const Gap(2),
        PaymentMethodItem(
          image: Assets.img.stok.icSaldoVa.image(width: 45, height: 45),
          title: 'Virtual Account',
          subtitle: 'Biaya Admin 1.000 - 3.500',
          onTap: () {
            pushNamed(BuatTiketVaPage.routeName);
          },
          details: [
            Row(
              children: [
                DetailInfo(
                  icon: MdiIcons.lightningBoltOutline,
                  text: '24 JAM',
                  iconColor: context.primary,
                  textColor: context.primary,
                ),
                const Gap(8),
                DetailInfo(
                  icon: MdiIcons.progressClock,
                  text: 'Pengisian saldo 4-10 menit',
                  iconColor: context.primary,
                  textColor: context.primary,
                ),
              ],
            ),
          ],
        ),
        const Gap(2),
        PaymentMethodItem(
          image: Assets.img.stok.icSaldoQr.image(width: 45, height: 45),
          title: 'QRIS',
          subtitle: 'Biaya Admin 0.7%',
          onTap: () {
            pushNamed(BuatTiketQrisPage.routeName);
          },
          details: [
            DetailInfo(
              icon: MdiIcons.lightningBoltOutline,
              text: '24 JAM',
              iconColor: context.primary,
              textColor: context.primary,
            ),
          ],
        ),
        const Gap(20),
      ],
    );
  }
}
