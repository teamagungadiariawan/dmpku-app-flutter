import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CardTotalBayarVa extends StatelessWidget {
  const CardTotalBayarVa({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      buildWhen: (previous, current) =>
          previous.tiketDuration != current.tiketDuration ||
          previous.selectedRiwayatVa != current.selectedRiwayatVa,
      builder: (context, state) {
        RiwayatTiketVAModel tiket = state.selectedRiwayatVa;

        String totalFormatted = ToCurrency(tiket.totalbayar.toString());

        return Card(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Column(
                children: [
                  Text(
                    "Total Bayar",
                    style: context.sectionTitle,
                    textHeightBehavior: AppTextHeightBehavior.noPadding,
                  ),
                  const Gap(5),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Rp ",
                              style: TextStyle(
                                color: context.isDarkMode
                                    ? slate[800]
                                    : slate[400],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              totalFormatted,
                              style: GoogleFonts.inconsolata(
                                color: context.foreground,
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          right: 0,
                          child: CustomButton(
                            text: "Salin",
                            icon: MdiIcons.contentCopy,
                            onPressed: () {
                              _copyToClipboard(
                                context,
                                "Total bayar",
                                tiket.totalbayar.toString(),
                              );
                            },
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: 32,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(12),
                  Container(
                    padding: paddingCard,
                    decoration: BoxDecoration(
                      color: context.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: context.primary),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.informationSlabCircle,
                          color: context.primary,
                          size: 20,
                        ),
                        const Gap(5),
                        Expanded(
                          child: Text(
                            "Pastikan nominal pembayaran sesuai dengan total bayar di atas.",
                            style: context.bodyMedium.withColor(
                              context.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
