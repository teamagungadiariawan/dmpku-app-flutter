import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardRincianTiketVa extends StatelessWidget {
  const CardRincianTiketVa({super.key});

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
                        "Rincian Pembayaran",
                        style: context.bodyLarge.withWeight(FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      padding: paddingCard,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(color: context.border, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Nominal Topup",
                              style: context.bodyMedium
                                  .withColor(context.mutedForeground)
                                  .withWeight(FontWeight.w600),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ToCurrency(tiket.nominal.toString()),
                              style: context.bodyMedium
                                  .withColor(context.foreground)
                                  .withWeight(FontWeight.w600),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingCard,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: tiket.tiketStatus.bgColor(context),
                            width: 2,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Biaya Admin",
                              style: context.bodyMedium
                                  .withColor(context.mutedForeground)
                                  .withWeight(FontWeight.w600),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ToCurrency(tiket.admin.toString()),
                              style: context.bodyMedium
                                  .withColor(context.foreground)
                                  .withWeight(FontWeight.w600),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: paddingCard,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Total Bayar",
                              style: context.bodyLarge.withWeight(
                                FontWeight.w600,
                              ),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              ToCurrency(tiket.totalbayar.toString()),
                              style: context.bodyLarge
                                  .withColor(context.foreground)
                                  .withWeight(FontWeight.w600),
                              textHeightBehavior:
                                  AppTextHeightBehavior.noPadding,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
