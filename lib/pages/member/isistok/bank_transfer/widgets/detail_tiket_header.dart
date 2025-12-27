import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailTiketHeader extends StatelessWidget {
  const DetailTiketHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      buildWhen: (previous, current) =>
          previous.tiketDuration != current.tiketDuration ||
          previous.selectedRiwayatTiket != current.selectedRiwayatTiket,
      builder: (context, state) {
        RiwayatTiketBankModel tiket = state.selectedRiwayatTiket;

        final formattedTime =
            '${state.tiketDuration.inHours.toString().padLeft(2, '0')}:${(state.tiketDuration.inMinutes % 60).toString().padLeft(2, '0')}:${(state.tiketDuration.inSeconds % 60).toString().padLeft(2, '0')}';

        final expiredDate =
            DateHelper.tryParse(tiket.expireddata) ?? DateTime.now();
        final formattedDate = DateHelper.formatFullDateWithDayShort(
          expiredDate,
        );
        final hourMinute = DateHelper.formatTime(expiredDate);

        return Container(
          height: 250,
          color: tiket.tiketStatus.bgColor(context),
          child: Stack(
            children: [
              Positioned.fill(
                child: RhombusPattern(
                  color: Colors.black.withValues(alpha: 0.05),
                  radius: 4,
                  spacing: 30,
                  isStaggered: false,
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomAppBar(
                      backgroundColor: Colors.transparent,
                      title: 'Detail Tiket Bank Transfer',
                      onBackButtonPressed: pop,
                    ),
                    const Gap(20),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: paddinPageh),
                      padding: paddingCard.copyWith(left: 16, right: 16),
                      decoration: BoxDecoration(
                        color: context.isDarkMode ? slate[800] : slate[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: tiket.tiketStatus.bgColor(context),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            tiket.tiketStatus.icon,
                            size: 20,
                            color: tiket.tiketStatus.textColorSecondary(
                              context,
                            ),
                          ),
                          const Gap(8),
                          Text(
                            !tiket.tiketStatus.isPending
                                ? tiket.tiketStatus.text
                                : formattedTime,
                            style: GoogleFonts.inconsolata(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: tiket.tiketStatus.textColorSecondary(
                                context,
                              ),
                            ),
                            textHeightBehavior: AppTextHeightBehavior.noPadding,
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Text(
                      "Batas waktu transfer",
                      style: context.sectionTitle
                          .withColor(Colors.white)
                          .withWeight(FontWeight.w600),
                    ),
                    Text(
                      "$formattedDate \u2022 $hourMinute",
                      style: context.pageTitle
                          .withColor(Colors.white)
                          .withWeight(FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
