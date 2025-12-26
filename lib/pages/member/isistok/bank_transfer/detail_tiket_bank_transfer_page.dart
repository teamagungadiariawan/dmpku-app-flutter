import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/model/riwayat_tiket_response.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/widgets/card_bank_info.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/widgets/card_rincian_tiket.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/widgets/card_total_transfer.dart';
import 'package:dmpku/pages/member/isistok/bank_transfer/widgets/detail_tiket_header.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/widgets/card_tanya.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class DetailTiketBankTransferPage extends StatefulWidget {
  static const routeName =
      '/member/isi-stok/bank-transfer/detail-tiket-bank-transfer';

  const DetailTiketBankTransferPage({super.key});

  @override
  State<DetailTiketBankTransferPage> createState() =>
      _DetailTiketBankTransferPageState();
}

class _DetailTiketBankTransferPageState
    extends State<DetailTiketBankTransferPage> {
  // --- Actions ---
  void closePage() {
    getMemberIsiStokProvider(
      context,
    ).setSelectedRiwayatTiket(DEFAULT_RIWAYAT_TIKET_BANK_MODEL);
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
              const DetailTiketHeader(),
              Padding(
                padding: paddingPage,
                child: Column(
                  children: [
                    const SizedBox(height: 200),
                    const CardTotalTransfer(),
                    const Gap(5),
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const CardBankInfo(),
                          const Gap(5),
                          const CardRincianTiket(),
                          const Gap(5),
                          BlocBuilder<
                            MemberIsiStokProvider,
                            MemberIsiStokState
                          >(
                            buildWhen: (previous, current) =>
                                previous.tiketDuration !=
                                    current.tiketDuration ||
                                previous.selectedRiwayatTiket !=
                                    current.selectedRiwayatTiket,
                            builder: (context, state) {
                              RiwayatTiketBankModel tiket =
                                  state.selectedRiwayatTiket;
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
