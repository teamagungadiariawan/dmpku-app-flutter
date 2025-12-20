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
import 'package:dmpku/pages/member/riwayat/cetak_struk_elektrik/member_cetak_struk_elektrik_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_elektrik/widgets/atur_harga_elektrik_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/atur_info_kios_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/pilih_printer_dialog.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';


class CetakStrukElektrikPage extends StatefulWidget {
  static const routeName = '/member/riwayat/cetak-struk-elektrik';

  const CetakStrukElektrikPage({super.key});

  @override
  State<CetakStrukElektrikPage> createState() => _CetakStrukElektrikPageState();
}

class _CetakStrukElektrikPageState extends State<CetakStrukElektrikPage> {
  final List<String> keyHide = ['totalbayar', 'totalpotongstok'];

  // REVISI: Max 32 Karakter
  final int maxChars = 32;

  void closePage() {
    getMemberCetakStrukElektrikProvider(context).resetState();
    pop();
  }

  @override
  void initState() {
    openAturHargaDialog();
    super.initState();
  }

  void openAturHargaDialog() async {
    await Future.delayed(const Duration(milliseconds: 300));

    final state = getMemberCetakStrukElektrikProvider(context).state;
    AturHargaElektrikDialog.show(
      context,
      initialHarga: state.harga,
      initialAdmin: state.admin,
    );
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
              color: Colors.black.withOpacity(0.05),
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
                    color: context.card.withOpacity(0.2),
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
                  color: Colors.black.withOpacity(0.3),
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
                  child: Container(
                    // Container ini buat batesin lebar visual jadi 280 (simulasi 58mm)
                    child:
                        BlocBuilder<
                          MemberCetakStrukElektrikProvider,
                          MemberCetakStrukElektrikState
                        >(
                          builder: (context, state) {
                            final String receiptData = _generateReceiptContent(
                              namaKios: state.namaKios,
                              alamatKios: state.alamatKios,
                              footerKios: state.footerKios,
                              dataTrx: state.dataTrx,
                              dataBiaya: state.dataBiaya,
                              totalBayar: state.totalBayar,
                              titleSn: state.titleSn,
                              sn: state.sn,
                            );

                            return Text(
                              receiptData,
                              style: const TextStyle(
                                fontFamily: 'monospace',
                                // Wajib Monospace
                                fontSize: 16,
                                color: Colors.black,
                                height: 1.15,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const Gap(5),
        BlocBuilder<
          MemberCetakStrukElektrikProvider,
          MemberCetakStrukElektrikState
        >(
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
    MemberCetakStrukElektrikState state,
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
                    AturHargaElektrikDialog.show(
                      context,
                      initialHarga: state.harga,
                      initialAdmin: state.admin,
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
                            getMemberCetakStrukElektrikProvider(
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
          CustomButton(
            width: double.infinity,
            padding: EdgeInsets.zero,
            height: 30,
            text: "Cetak Struk",
            onPressed: () {
              PrintStruk(
                namaKios: state.namaKios,
                alamatKios: state.alamatKios,
                footerKios: state.footerKios,
                dataTrx: state.dataTrx,
                dataBiaya: state.dataBiaya,
                totalBayar: state.totalBayar,
                titleSn: state.titleSn,
                sn: state.sn,
              );
            },
            icon: LucideIcons.printer,
          ),
        ],
      ),
    );
  }

  void PrintStruk({
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

  String _generateReceiptContent({
    String namaKios = "",
    String alamatKios = "",
    String footerKios = "",
    List<KeyValue> dataTrx = const [],
    List<KeyValue> dataBiaya = const [],
    String totalBayar = "",
    String titleSn = "",
    String sn = "",
  }) {
    StringBuffer buffer = StringBuffer();

    // 1. Helper: Print Tengah
    void pCenter(String text) {
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

    // 2. Helper: Print Kiri-Kanan (Smart Truncate)
    // Ini penting banget di 32 char biar ga error layoutnya
    void pRow(String left, String right) {
      int availableSpace = maxChars - right.length;

      // Kasih jarak minimal 1 spasi antara kiri dan kanan
      if (left.length > availableSpace - 1) {
        // Potong teks kiri kalau kepanjangan + kasih tanda ".."
        left = left.substring(0, availableSpace - 2) + "..";
      }

      int spaceCount = maxChars - left.length - right.length;
      String spaces = ' ' * spaceCount;
      buffer.writeln('$left$spaces$right');
    }

    // 3. Helper: Garis
    void pDivider() {
      buffer.writeln('-' * maxChars); // Pake dash biasa aja yg aman
    }

    // 4. Helper: Format Rupiah Simpel
    String formatRp(int value) {
      // Simulasi format ribuan pake titik (manual biar ga perlu intl package dulu)
      return value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (Match m) => '${m[1]}.',
      );
    }

    // --- ISI STRUK ---

    pCenter(namaKios);
    pCenter(alamatKios);
    pDivider();

    // Generate list stringnya
    List<String> formattedList = formatKeyValueMultilineNew(dataTrx);

    // Masukin ke buffer struk
    for (String line in formattedList) {
      buffer.writeln(line);
    }

    pDivider();

    formattedList = formatKeyValueMultilineNew(dataBiaya);

    // Masukin ke buffer struk
    for (String line in formattedList) {
      buffer.writeln(line);
    }

    pDivider();
    formattedList = formatKeyValueMultilineNew([
      KeyValue(key: "Total Bayar", value: ToCurrency(totalBayar)),
    ]);

    // Masukin ke buffer struk
    for (String line in formattedList) {
      buffer.writeln(line);
    }

    if (titleSn.isNotEmpty && sn.isNotEmpty) {
      pDivider();
      pCenter(titleSn);
      pCenter(sn);
    }

    pDivider();
    pCenter(footerKios);
    pDivider();

    return buffer.toString();
  }
}
