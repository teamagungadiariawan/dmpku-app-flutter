import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CardBankInfo extends StatelessWidget {
  const CardBankInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      buildWhen: (previous, current) =>
          previous.tiketDuration != current.tiketDuration ||
          previous.selectedRiwayatTiket != current.selectedRiwayatTiket,
      builder: (context, state) {
        RiwayatTiketBankModel tiket = state.selectedRiwayatTiket;

        return Card(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: paddingCard,
                  decoration: BoxDecoration(
                    color: !context.isDarkMode ? slate[50] : slate[800],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(8),
                    ),
                    border: Border(
                      bottom: BorderSide(color: context.border, width: 1),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Bank Tujuan: ${tiket.namaakun}",
                        style: context.bodyLarge.withWeight(FontWeight.w600),
                      ),
                      const Spacer(),
                      CustomNetworkImage(url: tiket.icon, size: 30),
                      const Gap(10),
                    ],
                  ),
                ),
                Padding(
                  padding: paddingCard,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No. Rekening",
                              style: context.bodyMedium
                                  .withColor(context.mutedForeground)
                                  .withWeight(FontWeight.w600),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                            ),
                            Text(
                              tiket.norekening,
                              style: GoogleFonts.inconsolata(
                                color: context.foreground,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              "a.n ${tiket.namarekening}",
                              style: context.bodyMedium
                                  .withColor(context.mutedForeground)
                                  .withWeight(FontWeight.w600),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: "Salin",
                        // Gw saranin text diperpendek biar gak nabrak harga di HP kecil
                        icon: MdiIcons.contentCopy,
                        onPressed: () {
                          _copyToClipboard(
                            context,
                            "No Rekening",
                            tiket.norekening,
                          );
                        },
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        height: 32,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _copyToClipboard(BuildContext context, String title, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '$title berhasil disalin ke clipboard',
          style: context.bodyMedium.withColor(Colors.white),
        ),
        backgroundColor: context.mutedForeground,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
