import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
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

class TransaksiProsesPage extends StatefulWidget {
  static const String routeName = '/member/produk/transaksi_proses';

  @override
  _TransaksiProsesPageState createState() => _TransaksiProsesPageState();
}

class _TransaksiProsesPageState extends State<TransaksiProsesPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlaDarkStyle(),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Lottie.asset(
                  Assets.animations.success,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    border: Border.all(color: context.border, width: 1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: paddingCard,
                        decoration: BoxDecoration(
                          color: context.primary,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          border: Border(
                            bottom: BorderSide(color: context.border, width: 1),
                          ),
                        ),
                        child: Text(
                          textAlign: TextAlign.center,
                          "Transaksi sedang di proses".toUpperCase(),
                          style: context.bodyLarge
                              .withColor(Colors.white)
                              .withWeight(FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: paddingCard,
                        child:
                            BlocBuilder<
                              TransaksiProsesProvider,
                              TransaksiProsesState
                            >(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          child: Image(
                                            image: state.image!,
                                            width: 30,
                                            height: 30,
                                          ),
                                        ),
                                        Gap(6),
                                        Expanded(
                                          child: Text(
                                            state.product.namaproduk,
                                            style: context.bodyLarge.withWeight(
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    _buildDetailItem(
                                      context,
                                      "Kode Produk",
                                      state.product.namaproduk,
                                    ),
                                    _buildDetailItem(
                                      context,
                                      "Potong Stok",
                                      ToCurrency(state.potongStok.toString()),
                                    ),
                                    _buildDetailItem(
                                      context,
                                      "No Tujuan",
                                      state.tujuan,
                                    ),

                                    Gap(8),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, String key, String value) {
    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.border, width: 1)),
      ),
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
}
