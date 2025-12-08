import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/paket_nelpon_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberPaketNelponKonfirmasiTransaksiPage extends StatefulWidget {
  static const routeName = '/member/produk/isiulang/paket_nelpon/konfirmasi-transaksi';

  const MemberPaketNelponKonfirmasiTransaksiPage({super.key});

  @override
  State<MemberPaketNelponKonfirmasiTransaksiPage> createState() =>
      _MemberPaketNelponKonfirmasiTransaksiPageState();
}

class _MemberPaketNelponKonfirmasiTransaksiPageState
    extends State<MemberPaketNelponKonfirmasiTransaksiPage> {
  void closePage() {
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: WillPopScope(
        onWillPop: () async {
          debugPrint("WillPopScope: onWillPop");
          closePage();
          return true; // true = izinkan pop
        },
        child: Scaffold(
          backgroundColor: context.primary,
          appBar: CustomAppBar(
            title: 'Konfirmasi Transaksi Paket Nelpon',
            onBackButtonPressed: closePage,
          ),
          body: Padding(
            padding: paddingPage,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
