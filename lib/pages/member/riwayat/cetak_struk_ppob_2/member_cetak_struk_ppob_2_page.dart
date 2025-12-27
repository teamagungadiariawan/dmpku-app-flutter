import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/printer_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/member_cetak_struk_ppob_2_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/widgets/atur_harga_ppob_2_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/atur_info_kios_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/pilih_printer_dialog.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart' show LucideIcons;
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

class MemberCetakStrukPpob2Page extends StatefulWidget {
  static const routeName = '/member/riwayat/cetak-struk-ppob-2';

  const MemberCetakStrukPpob2Page({Key? key}) : super(key: key);

  @override
  _MemberCetakStrukPpob2PageState createState() =>
      _MemberCetakStrukPpob2PageState();
}

class _MemberCetakStrukPpob2PageState extends State<MemberCetakStrukPpob2Page> {
  final List<String> keyHide = ['totalbayar', 'totalpotongstok'];

  // REVISI: Max 32 Karakter
  final int maxChars = 32;

  void closePage() {
    getMemberCetakStrukPpob2Provider(context).resetState();
    pop();
  }

  @override
  void initState() {
    openAturHargaDialog();
    super.initState();
  }

  void openAturHargaDialog() async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (!context.mounted) return;

    final state = getMemberCetakStrukPpob2Provider(context).state;
    AturHargaPpob2Dialog.show(context, initialadmin: state.admin);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: WillPopScope(
        onWillPop: () async {
          closePage();
          return true;
        },
        child: Scaffold(
          body: Stack(
            children: [
              _buildHeaderSection(context),
              _buildMainContent(context),
            ],
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION: HEADER (Background Berwarna)
  // ===========================================================================
  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      height: 250,
      color: context.primary,
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
              children: [
                _buildAppBar(context),
                const Gap(10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: context.card.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: context.primaryForeground,
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    LucideIcons.printer,
                    color: context.primaryForeground,
                    size: 24,
                  ),
                ),
                const Gap(10),
                Text(
                  "Pratinjau Cetak Struk",
                  textAlign: TextAlign.center,
                  style: context.sectionTitle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.primaryForeground,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      height: 80,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: InkWell(
        onTap: closePage,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Icon(LucideIcons.chevronLeft, size: 22, color: Colors.white),
            const Gap(5),
            Text(
              "Cetak Struk",
              style: context.bodyLarge.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Assets.img.status.icStatusSukses.image(height: 36, width: 36),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION: MAIN CONTENT (White Card)
  // ===========================================================================
  Widget _buildMainContent(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 180),
        Expanded(
          child: Container(
            width: double.infinity,
            margin: paddingPage,
            decoration: BoxDecoration(
              color: context.card,
              border: Border.all(color: context.border, width: 0.5),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 25,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            // Bungkus konten dalam ClipRRect biar pas discroll gak nembus rounded corner
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Center(
                // Tambahin Center biar kalau struk pendek, dia tetep di tengah (aesthetic)
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 24,
                  ),
                  physics: const BouncingScrollPhysics(),
                  // Biar ada mantulnya dikit (iOS style)
                  child:
                      BlocBuilder<
                        MemberCetakStrukPpob2Provider,
                        MemberCetakStrukPpob2State
                      >(
                        builder: (context, state) {
                          return _buildReceiptLayout(
                            namaKios: state.namaKios,
                            alamatKios: state.alamatKios,
                            footerKios: state.footerKios,
                            dataTrx: state.dataTrx,
                            dataBiaya: state.dataBiaya,
                            totalBayar: ToCurrency(state.totalBayar.toString()),
                            titleSn: state.titleSn,
                            sn: state.sn,
                          );
                        },
                      ),
                ),
              ),
            ),
          ),
        ),
        const Gap(5),
        BlocBuilder<MemberCetakStrukPpob2Provider, MemberCetakStrukPpob2State>(
          builder: (context, state) {
            return _buildFooterSection(context, state);
          },
        ),
        const Gap(30),
      ],
    );
  }

  // ===========================================================================
  // SECTION: FOOTER
  // ===========================================================================
  Widget _buildFooterSection(
    BuildContext context,
    MemberCetakStrukPpob2State state,
  ) {
    return Container(
      padding: paddingPage,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  padding: EdgeInsets.zero,
                  height: 30,
                  text: "Pilih Printer",
                  onPressed: () {
                    PilihPrinterDialog.show(context, selectedMacAddress: "");
                  },
                  icon: MdiIcons.printerSearch,
                ),
              ),
              Gap(6),
              Expanded(
                child: CustomButton(
                  padding: EdgeInsets.zero,
                  height: 30,
                  text: "Atur Harga",
                  onPressed: () {
                    AturHargaPpob2Dialog.show(
                      context,
                      initialadmin: state.admin,
                    );
                  },
                  icon: MdiIcons.cashEdit,
                ),
              ),
              Gap(6),
              Expanded(
                child: CustomButton(
                  padding: EdgeInsets.zero,
                  height: 30,
                  text: "Atur Info",
                  onPressed: () {
                    AturInfoKiosDialog.show(
                      context,
                      namaKios: state.namaKios,
                      alamatKios: state.alamatKios,
                      footerKios: state.footerKios,
                      onSave:
                          (
                            String namaKios,
                            String alamatKios,
                            String footerKios,
                          ) {
                            getMemberCetakStrukPpob2Provider(
                              context,
                            ).reloadKiosInfo();
                          },
                    );
                  },
                  icon: MdiIcons.storeEdit,
                ),
              ),
            ],
          ),
          Gap(10),
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  padding: EdgeInsets.zero,
                  height: 30,
                  text: "Bagikan Struk",
                  onPressed: () {
                    _handleShareFullPage(context, state);
                  },
                  icon: LucideIcons.share2,
                ),
              ),
              Gap(6),
              Expanded(
                child: CustomButton(
                  width: double.infinity,
                  padding: EdgeInsets.zero,
                  height: 30,
                  text: "Cetak Struk",
                  onPressed: () {
                    printStruk(
                      namaKios: state.namaKios,
                      alamatKios: state.alamatKios,
                      footerKios: state.footerKios,
                      dataTrx: state.dataTrx,
                      dataBiaya: state.dataBiaya,
                      totalBayar: ToCurrency(state.totalBayar.toString()),
                      titleSn: state.titleSn,
                      sn: state.sn,
                    );
                  },
                  icon: LucideIcons.printer,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void printStruk({
    String namaKios = "",
    String alamatKios = "",
    String footerKios = "",
    List<KeyValue> dataTrx = const [],
    List<KeyValue> dataBiaya = const [],
    String totalBayar = "",
    String titleSn = "",
    String sn = "",
  }) async {
    List<Map<String, dynamic>> struk = [
      {"text": namaKios, "align": "center", "newLine": 1},
      {"text": alamatKios, "align": "center", "newLine": 1},
      {"text": divider, "align": "center", "newLine": 1},
    ];

    List<String> formattedList = formatKeyValueMultilineNew(dataTrx);

    for (String line in formattedList) {
      struk.add({"text": line, "align": "left", "newLine": 1});
    }

    struk.add({"text": divider, "align": "center", "newLine": 1});

    formattedList = formatKeyValueMultilineNew(dataBiaya);

    for (String line in formattedList) {
      struk.add({"text": line, "align": "left", "newLine": 1});
    }

    struk.add({"text": divider, "align": "center", "newLine": 1});

    struk.add({
      "text": formatKeyValueMultilineNew([
        KeyValue(key: "Total Bayar", value: ToCurrency(totalBayar)),
      ]).first,
      "align": "left",
      "newLine": 1,
    });
    if (titleSn.isNotEmpty && sn.isNotEmpty) {
      struk.add({"text": divider, "align": "center", "newLine": 1});
      struk.add({
        "text": titleSn,
        "align": "center",
        "newLine": 1,
        "isToken": true,
      });
      struk.add({"text": sn, "align": "center", "newLine": 1, "isToken": true});
    }

    struk.add({"text": divider, "align": "center", "newLine": 1});
    struk.add({"text": footerKios, "align": "center", "newLine": 1});
    struk.add({"text": " ", "align": "center", "newLine": 1});
    struk.add({"text": " ", "align": "center", "newLine": 1});

    var myPrinterName =
        await SecureStorageHelper.instance.getPrinterName() ?? "";
    var myPrinterMac =
        await SecureStorageHelper.instance.getPrinterMacAddress() ?? "";

    debugPrint(
      "PRINT STRUK ELEKTRIK TO PRINTER: $myPrinterName - $myPrinterMac",
    );

    // 3. Panggil fungsi print
    await PrinterNativeHelper.printData(
      printerName: myPrinterName,
      printerAddress: myPrinterMac,
      items: struk,
    );
  }

  Widget _buildReceiptLayout({
    String namaKios = "",
    String alamatKios = "",
    String footerKios = "",
    List<KeyValue> dataTrx = const [],
    List<KeyValue> dataBiaya = const [],
    String totalBayar = "",
    String titleSn = "",
    String sn = "",
  }) {
    // 1. Helper: Print Tengah
    void pCenter(StringBuffer buffer, String text) {
      // Loop: Selama text lebih panjang dari maxChars (32)
      while (text.length > maxChars) {
        // Ambil potongan selebar maxChars
        String chunk = text.substring(0, maxChars);
        // Print potongan tersebut (karena full width, otomatis rata kiri-kanan)
        buffer.writeln(chunk);

        // Buang bagian yang sudah diprint, lanjut ke sisanya
        text = text.substring(maxChars);
      }

      // --- Cetak Sisa Text (atau text yang emang pendek) ---
      // Logic centering original
      if (text.isNotEmpty) {
        int padding = (maxChars - text.length) ~/ 2;
        String spaces = ' ' * padding;
        buffer.writeln((spaces + text).padRight(maxChars));
      }
    }

    // 3. Helper: Garis
    void pDivider(StringBuffer buffer, {bool newLine = true}) {
      if (newLine)
        buffer.writeln('-' * maxChars);
      else
        buffer.write('-' * maxChars);
    }

    StringBuffer buffer = StringBuffer();

    pCenter(buffer, namaKios);
    pCenter(buffer, alamatKios);
    pDivider(buffer);

    List<String> formattedList = formatKeyValueMultilineNew(dataTrx);
    for (String line in formattedList) {
      buffer.writeln(line);
    }
    pDivider(buffer);
    formattedList = formatKeyValueMultilineNew(dataBiaya);

    for (String line in formattedList) {
      buffer.writeln(line);
    }
    pDivider(buffer);
    formattedList = formatKeyValueMultilineNew([
      KeyValue(key: "Total Bayar", value: ToCurrency(totalBayar)),
    ]);

    for (String line in formattedList) {
      buffer.writeln(line);
    }
    pDivider(buffer, newLine: false);

    const styleBig = TextStyle(
      fontFamily: 'monospace',
      fontSize: 24,
      // <--- UKURAN FONT DIPERBESAR
      color: Colors.black,
      height: 1.15,
      fontWeight: FontWeight.w900, // Lebih tebal
    );

    StringBuffer bufferBottom = StringBuffer();
    pDivider(bufferBottom);
    pCenter(bufferBottom, footerKios);
    pDivider(bufferBottom);

    String strSn = "";
    if (titleSn.isNotEmpty && sn.isNotEmpty) {
      // split sn jika terlalu panjang jadi array
      List<String> snLines = [];
      int start = 0;
      int max = (maxChars / 2).toInt();
      while (start < sn.length) {
        int end = (start + max < sn.length) ? start + (max) : sn.length;
        snLines.add(sn.substring(start, end));
        start += max;
      }

      strSn = snLines.join('\n');
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          buffer.toString(),
          style: const TextStyle(
            fontFamily: 'monospace',
            // Wajib Monospace
            fontSize: 16,
            color: Colors.black,
            height: 1.15,
            fontWeight: FontWeight.w500,
          ),
        ),
        if (titleSn.isNotEmpty && sn.isNotEmpty) ...[
          Text(
            titleSn,
            style: styleBig.copyWith(fontSize: 18), // Judul agak besar dikit
            textAlign: TextAlign.center,
          ),
          const Gap(2),
          Text(
            strSn,
            style: styleBig, // SN SANGAT BESAR
            textAlign: TextAlign.center,
          ),
        ],
        Text(
          bufferBottom.toString(),
          style: const TextStyle(
            fontFamily: 'monospace',
            // Wajib Monospace
            fontSize: 16,
            color: Colors.black,
            height: 1.15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // 1. Tambahkan Controller Screenshot
  final ScreenshotController screenshotController = ScreenshotController();

  // ... method lain (closePage, initState, dll)

  // 2. Tambahkan Function Share Struk Thermal
  Future<void> _handleShareFullPage(
    BuildContext context,
    MemberCetakStrukPpob2State state,
  ) async {
    // Capture Widget
    // Kita bikin container putih biar mirip kertas struk asli
    final Uint8List image = await screenshotController.captureFromWidget(
      Container(
        width: 380,
        // Lebar fixed biar hasil gambarnya proporsional kayak struk 58mm
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
        color: Colors.white,
        // Warna kertas
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildReceiptLayout(
              namaKios: state.namaKios,
              alamatKios: state.alamatKios,
              footerKios: state.footerKios,
              dataTrx: state.dataTrx,
              dataBiaya: state.dataBiaya,
              totalBayar: ToCurrency(state.totalBayar.toString()),
              titleSn: state.titleSn,
              sn: state.sn,
            ),
            const Gap(30),
            Text(
              "Simpan bukti transaksi ini.",
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12,
                fontFamily: 'sans-serif',
              ),
            ),
          ],
        ),
      ),
      delay: const Duration(milliseconds: 100),
      context: context,
    );

    // Proses Simpan & Share
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = await File(
      '${directory.path}/struk_thermal.png',
    ).create();
    await imagePath.writeAsBytes(image);
    await Share.shareXFiles([XFile(imagePath.path)], text: 'Struk Transaksi');
  }
}
