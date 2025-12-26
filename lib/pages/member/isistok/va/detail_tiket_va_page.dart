import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/isistok/va/widgets/card_cara_bayar_va.dart';
import 'package:dmpku/pages/member/isistok/va/widgets/card_rincian_tiket_va.dart';
import 'package:dmpku/pages/member/isistok/va/widgets/card_total_bayar_va.dart';
import 'package:dmpku/pages/member/isistok/va/widgets/card_va_info.dart';
import 'package:dmpku/pages/member/isistok/va/widgets/detail_tiket_va_header.dart';
import 'package:dmpku/widgets/card_tanya.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DetailTiketVaPage extends StatefulWidget {
  static const routeName = '/member/isistok/va/detail_tiket';

  const DetailTiketVaPage({super.key});

  @override
  State<DetailTiketVaPage> createState() => _DetailTiketVaPageState();
}

class _DetailTiketVaPageState extends State<DetailTiketVaPage> {
  void closePage() {
    getMemberIsiStokProvider(
      context,
    ).setSelectedRiwayatVa(DEFAULT_RIWAYAT_TIKET_VA);
    getMemberIsiStokProvider(context).stopTimerDebounce();
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) return;
          closePage();
        },
        child: Scaffold(
          body: Stack(
            children: [
              const DetailTiketVaHeader(),
              Padding(
                padding: paddingPage,
                child: Column(
                  children: [
                    const SizedBox(height: 200),
                    const CardTotalBayarVa(),
                    const Gap(5),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const CardVaInfo(),
                          const Gap(5),
                          const CardRincianTiketVa(),
                          const Gap(5),
                          const CardCaraBayarVa(),
                          const Gap(5),
                          BlocBuilder<
                            MemberIsiStokProvider,
                            MemberIsiStokState
                          >(
                            buildWhen: (previous, current) =>
                                previous.tiketDuration !=
                                    current.tiketDuration ||
                                previous.selectedRiwayatVa !=
                                    current.selectedRiwayatVa,
                            builder: (context, state) {
                              RiwayatTiketVAModel tiket =
                                  state.selectedRiwayatVa;
                              return CardTanya(
                                onTap: () {},
                                title: "Ada kendala saat isi stok?",
                                borderColor: tiket.tiketStatus.bgColor(context),
                              );
                            },
                          ),
                          const Gap(30),
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
  }
}
