import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/card_informasi.dart';
import 'package:dmpku/widgets/card_tanya.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

import 'detail_transaksi_item.dart';

class MemberPaketCuanKonfirmasiTransaksiPage extends StatefulWidget {
  static const routeName = '/member/paketcuan/konfirmasi-transaksi';

  const MemberPaketCuanKonfirmasiTransaksiPage({super.key});

  @override
  State<MemberPaketCuanKonfirmasiTransaksiPage> createState() =>
      _MemberPaketCuanKonfirmasiTransaksiPageState();
}

class _MemberPaketCuanKonfirmasiTransaksiPageState
    extends State<MemberPaketCuanKonfirmasiTransaksiPage> {
  void closePage() {
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: PopScope(
        canPop: true,
        onPopInvokedWithResult: (didPop, result) {
          if (!didPop) closePage();
        },
        child: Scaffold(
          backgroundColor: context.primary,
          appBar: CustomAppBar(
            title: 'Konfirmasi Pembelian',
            onBackButtonPressed: closePage,
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Header
                _buildHeader(context),
                const Gap(8),
                // Saldo Card
                _buildSaldoCard(context),
                const Gap(8),
                // Detail Content dengan CustomScrollView
                _buildDetailContent(context),
                // Border Bottom Image
                Assets.img.borderBottom.image(
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                const Gap(20),
                // Bottom Action
                _buildBottomAction(context),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Assets.img.icHistory.image(width: 24, height: 24),
        const Gap(5),
        Text(
          'Detail Pembelian',
          style: context.pageTitle
              .withColor(Colors.white)
              .withWeight(FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildSaldoCard(BuildContext context) {
    return BlocBuilder<MemberProvider, MemberState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
          ),
          child: Row(
            children: [
              const Icon(MdiIcons.walletOutline, color: Colors.white, size: 36),
              const Gap(5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Stok Anda",
                    style: context.bodyMedium.withColor(Colors.white),
                  ),
                  Text(
                    state.profile.formatSaldo,
                    style: context.bodyLarge
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailContent(BuildContext context) {
    return BlocBuilder<MemberPaketCuanProvider, MemberPaketCuanState>(
      builder: (context, state) {
        final detailTransaksi = [
          DetailTransaksiItem(key: 'No. Tujuan', value: state.tujuan),
          DetailTransaksiItem(key: 'Produk', value: state.selectedProduct.namapaket),
        ];

        final detailPotongStok = [
          DetailTransaksiItem(key: 'Harga', value: ToCurrency(state.selectedProduct.hargapaket.toString())),
        ];

        final totalPotongStok = state.selectedProduct.hargapaket;

        return Expanded(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.card,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                // Product Info - FIXED di atas
                _buildProductInfo(context, state),
                const Gap(10),
                Divider(height: 1, thickness: 2, color: context.primary),
                const Gap(5),

                // Scrollable content
                Expanded(
                  child: CustomScrollView(
                    slivers: [
                      // Detail Transaksi Header
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, bottom: 8),
                          child: Text(
                            "Detail Transaksi",
                            style: context.bodyMedium.withWeight(
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // Detail Transaksi List
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = detailTransaksi[index];
                          return _buildDetailItem(context, item);
                        }, childCount: detailTransaksi.length),
                      ),

                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8),
                          padding: paddingCard,
                          decoration: BoxDecoration(
                            color: context.isDarkMode ? slate[600] : slate[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            "Detail Potong Stok",
                            style: context.bodyMedium.withWeight(
                              FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      // Detail Transaksi List
                      SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = detailPotongStok[index];
                          return _buildDetailItem(context, item);
                        }, childCount: detailPotongStok.length),
                      ),

                      SliverToBoxAdapter(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          margin: const EdgeInsets.only(top: 8),
                          decoration: BoxDecoration(
                            color: context.primary,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(8),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total Potong Stok",
                                  style: context.bodyMedium
                                      .withWeight(FontWeight.w600)
                                      .withColor(Colors.white),
                                ),
                              ),
                              Text(
                                ToCurrency(totalPotongStok.toString()),
                                style: context.bodyMedium
                                    .withWeight(FontWeight.w800)
                                    .withColor(Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SliverToBoxAdapter(child: Gap(4)),
                      SliverToBoxAdapter(child: CardInformasi()),
                      SliverToBoxAdapter(
                        child: CardTanya(onTap: () {}, title: "Ada kendala?"),
                      ),

                      // ... sisa sliver lainnya
                      const SliverToBoxAdapter(child: Gap(12)),
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

  Widget _buildProductInfo(BuildContext context, MemberPaketCuanState state) {
    return Container(
      padding: paddingCard,
      decoration: BoxDecoration(
        color: context.isDarkMode ? slate[600] : slate[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Image.network(
            state.selectedProvider.imgprovider,
            width: 48,
            height: 48,
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  state.selectedProduct.namapaket,
                  style: context.bodyMedium.withWeight(FontWeight.w600),
                ),
                const Gap(4),
                Divider(height: 1, thickness: 2, color: context.primary),
                const Gap(4),
                Text(
                  state.selectedProduct.detailpaket,
                  style: context.bodySmall.withColor(context.foreground),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, DetailTransaksiItem item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.border, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                item.key,
                style: context.bodyMedium.withWeight(FontWeight.w600),
              ),
            ),
          ),

          Container(
            constraints:  BoxConstraints(maxWidth: 150),
            child: Text(
              item.value,
              textAlign: TextAlign.end,
              style: context.bodyMedium.withWeight(FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context) {
    return BlocBuilder<MemberPaketCuanProvider, MemberPaketCuanState>(
      builder: (context, state) {
        return Row(
          children: [
            Assets.img.icCoin.image(width: 36, height: 36),
            const Gap(15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Potong Stok',
                  style: context.bodyLarge
                      .withColor(Colors.white)
                      .withWeight(FontWeight.w600),
                ),
                Text(
                  ToRupiah(state.selectedProduct.hargapaket.toString()),
                  style: context.sectionTitle
                      .withColor(Colors.white)
                      .withWeight(FontWeight.w800),
                ),
              ],
            ),
            const Spacer(),
            CustomButton(
              width: 150,
              padding: EdgeInsets.zero,
              text: "Lanjutkan",
              onPressed: () {
                // TODO: Implement konfirmasiTrx
              },
              variant: ButtonVariant.border,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              borderColor: Colors.white,
              textStyle: context.bodyLarge
                  .withColor(Colors.white)
                  .withWeight(FontWeight.w600),
            ),
          ],
        );
      },
    );
  }
}
