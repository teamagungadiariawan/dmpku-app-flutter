import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/paket_data_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MemberPaketDataKonfirmasiTransaksiPage extends StatefulWidget {
  static const routeName = '/member/produk/isiulang/paket_data/konfirmasi-transaksi';

  const MemberPaketDataKonfirmasiTransaksiPage({super.key});

  @override
  State<MemberPaketDataKonfirmasiTransaksiPage> createState() =>
      _MemberPaketDataKonfirmasiTransaksiPageState();
}

class _MemberPaketDataKonfirmasiTransaksiPageState
    extends State<MemberPaketDataKonfirmasiTransaksiPage> {
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
            title: 'Konfirmasi Transaksi Paket Data',
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
