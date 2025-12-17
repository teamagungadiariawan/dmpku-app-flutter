import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/pages/member/member_main_page.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';

class TransaksiProsesAktivasiVoucherPage extends StatefulWidget {
  static const String routeName =
      '/member/produk/transaksi_proses/aktivasi_voucher';

  @override
  _TransaksiProsesAktivasiVoucherPageState createState() =>
      _TransaksiProsesAktivasiVoucherPageState();
}

class _TransaksiProsesAktivasiVoucherPageState
    extends State<TransaksiProsesAktivasiVoucherPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlaDarkStyle(),
      child: WillPopScope(
        onWillPop: () async {
          debugPrint("WillPopScope: onWillPop");
          pushNamedAndRemoveUntil(MemberMainPage.routeName);
          return true; // true = izinkan pop
        },
        child: Scaffold(
          backgroundColor: context.isDarkMode ? slate[600] : slate[200],
          body: SafeArea(
            child: Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: paddingCard,
                decoration: BoxDecoration(
                  color: context.background,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: context.isDarkMode
                          ? Colors.black.withOpacity(0.5)
                          : Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: BlocBuilder<TransaksiProsesProvider, TransaksiProsesState>(
                  builder: (context, state) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Lottie.asset(
                          Assets.animations.successNew,
                          height: 200,
                          fit: BoxFit.cover,
                        ),

                        Gap(12),

                        Text(
                          "Transaksi sedang di proses",
                          style: context.pageTitle
                              .withColor(context.primary)
                              .withWeight(FontWeight.w600),
                        ),
                        Gap(15),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: paddingCard,
                          decoration: BoxDecoration(
                            color: context.isDarkMode ? slate[600] : slate[100],
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: context.background,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                child: Image(
                                  image: state.image!,
                                  width: 30,
                                  height: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Gap(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Item", style: context.bodySmall),
                                    Text(
                                      state.product.namaproduk,
                                      style: context.bodyMedium.withWeight(
                                        FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Gap(12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Harga", style: context.bodySmall),
                                  Text(
                                    "Rp ${ToCurrency(state.potongStok.toString())}",
                                    style: context.bodyMedium
                                        .withWeight(FontWeight.w600)
                                        .withColor(context.primary),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Gap(10),
                        ListView.builder(
                          itemBuilder: (context, index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width * 0.8,
                              padding: paddingCard,
                              decoration: BoxDecoration(
                                color: context.isDarkMode
                                    ? slate[600]
                                    : slate[100],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Tujuan " + (index + 1).toString(),
                                          style: context.bodySmall,
                                        ),
                                        Text(
                                          state.tujuanHistory[index].tujuan,
                                          style: context.bodyMedium.withWeight(
                                            FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (state.tujuanHistory[index].success) ...[
                                    Text(
                                      "Berhasil",
                                      style: context.bodyMedium
                                          .withWeight(FontWeight.w600)
                                          .withColor(context.primary),
                                    ),
                                  ] else ...[
                                    Text(
                                      "Gagal",
                                      style: context.bodyMedium
                                          .withWeight(FontWeight.w600)
                                          .withColor(context.destructive),
                                    ),
                                  ],
                                  Gap(12),
                                  InkWell(
                                    onTap: () {
                                      _copyToClipboard(
                                        context,
                                        state.tujuanHistory[index].tujuan,
                                      );
                                    },
                                    child: Icon(
                                      Icons.copy,
                                      size: 20,
                                      color: context.primary,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          itemCount: state.tujuanHistory.length,
                          shrinkWrap: true,
                        ),
                        Gap(5),
                        _buildDetailItem(
                          context,
                          "Waktu Transaksi",
                          state.waktuTransaksi,
                        ),
                        Gap(8),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CustomButton(
                                height: 30,
                                padding: EdgeInsets.zero,
                                variant: ButtonVariant.primary,
                                text: "Beranda",
                                onPressed: () {
                                  pushNamedAndRemoveUntil(
                                    MemberMainPage.routeName,
                                  );
                                },
                              ),
                            ),
                            Gap(10),
                            Expanded(
                              child: CustomButton(
                                height: 30,
                                padding: EdgeInsets.zero,
                                variant: ButtonVariant.border,
                                borderColor: context.primary,
                                foregroundColor: context.primary,
                                text: "Riwayat Transaksi",
                                onPressed: () {
                                  pushNamedAndRemoveUntil(
                                    MemberMainPage.routeName,
                                    arguments: 1, // 1 = Index tab Riwayat
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String key, String value) {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                key,
                style: context.bodyMedium.withWeight(FontWeight.w600),
              ),
            ),
          ),
          Text(value, style: context.bodyMedium.withWeight(FontWeight.w400)),
        ],
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'ID Tujuan berhasil disalin',
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
