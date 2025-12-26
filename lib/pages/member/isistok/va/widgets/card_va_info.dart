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

class CardVaInfo extends StatelessWidget {
  const CardVaInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      buildWhen: (previous, current) =>
          previous.tiketDuration != current.tiketDuration ||
          previous.selectedRiwayatVa != current.selectedRiwayatVa,
      builder: (context, state) {
        RiwayatTiketVAModel tiket = state.selectedRiwayatVa;

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
                        "Nm. Penerima : ${tiket.nama}",
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
                              "Nomor Virtual Account",
                              style: context.bodyMedium
                                  .withColor(context.mutedForeground)
                                  .withWeight(FontWeight.w600),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                            ),
                            Text(
                              tiket.nova,
                              style: GoogleFonts.inconsolata(
                                color: context.foreground,
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomButton(
                        text: "Salin",
                        icon: MdiIcons.contentCopy,
                        onPressed: () {
                          _copyToClipboard(
                            context,
                            "Nomor Virtual Account",
                            tiket.nova,
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
