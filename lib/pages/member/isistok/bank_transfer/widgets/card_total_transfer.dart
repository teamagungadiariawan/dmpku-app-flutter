import 'package:dmpku/core/enums/status_tiket.dart';
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

class CardTotalTransfer extends StatelessWidget {
  const CardTotalTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      buildWhen: (previous, current) =>
          previous.tiketDuration != current.tiketDuration ||
          previous.selectedRiwayatTiket != current.selectedRiwayatTiket,
      builder: (context, state) {
        RiwayatTiketBankModel tiket = state.selectedRiwayatTiket;
        StatusTiket statusTiket = StatusTiket.fromId(tiket.status);

        String totalRaw = tiket.jumlahnominalantriantiket.toString();
        String uniqueCodeRaw = tiket.noantriantiket.toString();
        // 2. Format Total: "27291" -> "27.291"
        String totalFormatted = ToCurrency(totalRaw);
        String uniqueCodeFormatted = ToCurrency(uniqueCodeRaw);

        // 3. Logic Pemisahan String
        // Kita perlu memisahkan "27." dari "291"
        // Caranya: Ambil substring dari totalFormatted, kurangi panjang uniqueCodeRaw
        String mainPrice = "";
        String highlightedCode = "";

        if (totalFormatted.endsWith(uniqueCodeFormatted)) {
          mainPrice = totalFormatted.substring(
            0,
            totalFormatted.length - uniqueCodeFormatted.length,
          );
          highlightedCode = uniqueCodeFormatted;
        } else {
          // Fallback jika format tidak sesuai ekspektasi (misal kode unik terpotong titik)
          mainPrice = totalFormatted;
          highlightedCode = "";
        }

        return Card(
          child: SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 20,
              ),
              child: Column(
                children: [
                  Text(
                    "Total Transfer",
                    style: context.sectionTitle,
                    textHeightBehavior: AppTextHeightBehavior.noPadding,
                  ),
                  const Gap(5),
                  // --- Row Harga (Rp + Main + Highlight) ---
                  // Bungkus pake Container/SizedBox biar Stack-nya tau dia harus selebar apa
                  SizedBox(
                    width: double.infinity,
                    height: 50, // Sesuaikan tinggi area ini biar button muat
                    child: Stack(
                      alignment: Alignment.center,
                      // INI KUNCINYA: Default semua anak di tengah
                      children: [
                        // ---------------------------------------------
                        // 1. LAYER TEXT HARGA (Tetap di tengah Card)
                        // ---------------------------------------------
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          // Biar sejajar garis bawah text
                          textBaseline: TextBaseline.alphabetic,
                          mainAxisSize: MainAxisSize.min,
                          // Penting biar Row gak makan full width sendirian
                          children: [
                            // "Rp" (Abu-abu)
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
                            // "27." (Hitam Besar)
                            Text(
                              mainPrice,
                              style: GoogleFonts.inconsolata(
                                color: context.foreground,
                                fontSize: 36,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            // "291" (Box Kuning)
                            if (highlightedCode.isNotEmpty) ...[
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                  vertical: 0,
                                ),
                                decoration: BoxDecoration(
                                  color: statusTiket
                                      .bgColor(context)
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: statusTiket.bgColor(context),
                                  ),
                                ),
                                child: Text(
                                  highlightedCode,
                                  style: GoogleFonts.inconsolata(
                                    color: statusTiket.textColorSecondary(
                                      context,
                                    ),
                                    fontSize: 36,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),

                        // ---------------------------------------------
                        // 2. LAYER BUTTON (Dipaksa ke Kanan)
                        // ---------------------------------------------
                        Positioned(
                          right: 0,
                          // Tempel ke kanan mentok
                          // top: 0, bottom: 0, // Opsional: kalo mau button centering vertical manual
                          child: CustomButton(
                            text: "Salin",
                            // Gw saranin text diperpendek biar gak nabrak harga di HP kecil
                            icon: MdiIcons.contentCopy,
                            onPressed: () {
                              _copyToClipboard(
                                context,
                                "Total transfer",
                                tiket.jumlahnominalantriantiket.toString(),
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
                      color: context.destructive.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: context.destructive),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          MdiIcons.informationSlabCircle,
                          color: context.destructive,
                          size: 20,
                        ),

                        const Gap(5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "PENTING: Transfer Tepat ${uniqueCodeRaw.length} Digit Terakhir",
                                style: context.bodyLarge
                                    .withColor(context.destructive)
                                    .withWeight(FontWeight.w600),
                              ),
                              Text(
                                "Pastikan kamu mentransfer jumlah total di atas secara tepat agar proses verifikasi dapat berjalan lancar.",
                                style: context.bodySmall.withColor(
                                  context.destructive,
                                ),
                                textHeightBehavior:
                                    AppTextHeightBehavior.noPadding,
                              ),
                            ],
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
