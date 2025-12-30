import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/date_helper.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/printer_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/pages/member/riwayat/widgets/atur_info_kios_dialog.dart';
import 'package:dmpku/pages/member/riwayat/widgets/pilih_printer_dialog.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DetailPenjualanPage extends StatefulWidget {
  static const routeName = '/member/kasir/detail_penjualan';

  const DetailPenjualanPage({super.key});

  @override
  State<DetailPenjualanPage> createState() => _DetailPenjualanPageState();
}

class _DetailPenjualanPageState extends State<DetailPenjualanPage> {
  void closePage() {
    context.read<KasirProvider>().setSelectedPenjualan(null);
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
          backgroundColor: bgScreen,
          bottomNavigationBar: _buildBottomBar(context),
          body: BlocBuilder<KasirProvider, KasirState>(
            builder: (context, state) {
              final penjualan = state.selectedPenjualan;

              if (penjualan == null) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }

              final profit = penjualan.jumlahbayar - penjualan.jumlahmodal;

              return Stack(
                children: [
                  _buildHeaderSection(context, penjualan, profit),
                  _buildMainContent(context, penjualan, profit),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION: HEADER
  // ===========================================================================
  Widget _buildHeaderSection(
    BuildContext context,
    PenjualanModel penjualan,
    int profit,
  ) {
    return Container(
      color: context.primary,
      height: 200,
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
          Column(
            children: [
              CustomAppBar(
                backgroundColor: Colors.transparent,
                title: 'Detail Penjualan',
                onBackButtonPressed: pop,
              ),
              _buildProfitDisplay(context, penjualan, profit),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProfitDisplay(
    BuildContext context,
    PenjualanModel penjualan,
    int profit,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "KEUNTUNGAN BERSIH",
                style: context.bodyMedium.withColor(Colors.white),
              ),
              const Gap(8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.receipt_long,
                      size: 12,
                      color: Colors.white,
                    ),
                    const Gap(4),
                    Text(
                      "#TRX${penjualan.idpenjualan}",
                      style: context.bodyMedium.withColor(Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Text(
            ToRupiah(profit.toString()),
            style: context.pageTitle
                .withSize(40)
                .withColor(Colors.white)
                .withWeight(FontWeight.bold),
          ),
        ],
      ),
    );
  }

  // ===========================================================================
  // SECTION: MAIN CONTENT
  // ===========================================================================
  Widget _buildMainContent(
    BuildContext context,
    PenjualanModel penjualan,
    int profit,
  ) {
    var waktuTrx = DateHelper.tryParse(penjualan.waktutrx) ?? DateTime.now();

    return Padding(
      padding: paddingPage,
      child: ListView(
        children: [
          const SizedBox(height: 115),
          Card(
            child: Padding(
              padding: paddingCard,
              child: Column(
                children: [
                  _buildSummaryRow(context, penjualan, profit),
                  const Gap(5),
                  Divider(height: 1, thickness: 1, color: context.border),
                  const Gap(5),
                  _buildPaymentRow(context, penjualan),
                ],
              ),
            ),
          ),
          const Gap(10),
          _buildStatusCard(context, penjualan, waktuTrx),
          const Gap(10),
          _buildActionButtons(context),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: InkWell(
              onTap: () {
                // Chat Pembeli functionality
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: paddingCard,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      MdiIcons.chatProcessing,
                      size: 20,
                      color: context.primary,
                    ),
                    const Gap(8),
                    Text(
                      "Chat Pembeli",
                      style: context.bodyMedium.withWeight(FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const Gap(10),
        Expanded(
          child: Card(
            child: InkWell(
              onTap: () {
                // Bantuan CS functionality
              },
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: paddingCard,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(MdiIcons.headset, size: 20, color: context.success),
                    const Gap(8),
                    Text(
                      "Bantuan CS",
                      style: context.bodyMedium.withWeight(FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      padding: paddingPage.copyWith(top: 12, bottom: 12),
      decoration: BoxDecoration(
        color: context.card,
        border: Border(top: BorderSide(color: context.border)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _buildSmallActionButton(
              context,
              label: "Pilih Printer",
              icon: MdiIcons.printer,
              onTap: () => _handlePilihPrinter(context),
            ),
            const Gap(10),
            _buildSmallActionButton(
              context,
              label: "Atur Kios",
              icon: MdiIcons.store,
              onTap: () => _handleAturKios(context),
            ),
            const Gap(10),
            Expanded(
              child: CustomButton(
                text: "CETAK STRUK",
                icon: MdiIcons.receiptText,
                onPressed: () => _handleCetakStruk(context),
                backgroundColor: context.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(color: context.border),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: context.mutedForeground),
            const Gap(6),
            Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: context.bodySmall
                  .withWeight(FontWeight.w600)
                  .withColor(context.mutedForeground)
                  .withSize(11),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // SECTION: HANDLERS
  // ===========================================================================
  void _handlePilihPrinter(BuildContext context) async {
    final macAddress =
        await SecureStorageHelper.instance.getPrinterMacAddress() ?? "";
    PilihPrinterDialog.show(context, selectedMacAddress: macAddress);
  }

  void _handleAturKios(BuildContext context) async {
    final namaKios = await SecureStorageHelper.instance.getNamaKios() ?? "";
    final alamatKios = await SecureStorageHelper.instance.getAlamatKios() ?? "";
    final footerKios = await SecureStorageHelper.instance.getFooterKios() ?? "";

    AturInfoKiosDialog.show(
      context,
      namaKios: namaKios,
      alamatKios: alamatKios,
      footerKios: footerKios,
      onSave: (String nama, String alamat, String footer) {
        // Reload jika diperlukan
      },
    );
  }

  void _handleCetakStruk(BuildContext context) async {
    final state = context.read<KasirProvider>().state;
    final penjualan = state.selectedPenjualan;
    final items = state.listPenjualanDetail;

    if (penjualan == null) return;

    // Get kios info
    final namaKios = await SecureStorageHelper.instance.getNamaKios() ?? "";
    final alamatKios = await SecureStorageHelper.instance.getAlamatKios() ?? "";
    final footerKios = await SecureStorageHelper.instance.getFooterKios() ?? "";

    // Build struk data
    List<Map<String, dynamic>> struk = [
      {"text": namaKios, "align": "center", "newLine": 1},
      {"text": alamatKios, "align": "center", "newLine": 1},
      {"text": divider, "align": "center", "newLine": 1},
    ];

    // Transaction info
    List<KeyValue> dataTrx = [
      KeyValue(key: "ID Transaksi", value: "#TRX${penjualan.idpenjualan}"),
      KeyValue(
        key: "Waktu",
        value: DateHelper.formatDateTime(
          DateHelper.tryParse(penjualan.waktutrx) ?? DateTime.now(),
        ),
      ),
      KeyValue(
        key: "Status",
        value: penjualan.status == 1 ? "Sukses" : "Refund",
      ),
    ];

    List<String> formattedList = formatKeyValueMultilineNew(dataTrx);
    for (String line in formattedList) {
      struk.add({"text": line, "align": "left", "newLine": 1});
    }

    struk.add({"text": divider, "align": "center", "newLine": 1});

    // Product items
    for (var item in items) {
      struk.add({"text": item.namaproduk, "align": "left", "newLine": 1});
      List<KeyValue> dataItem = [
        KeyValue(
          key: "${item.jumlah} x ${ToCurrency(item.hargajual.toString())}",
          value: ToCurrency(item.subtotalhargajual.toString()),
        ),
      ];

      List<String> formattedList = formatKeyValueMultilineNew(dataItem);
      for (String line in formattedList) {
        struk.add({"text": line, "align": "left", "newLine": 1});
      }
    }
    struk.add({"text": divider, "align": "center", "newLine": 1});

    // Payment info
    List<KeyValue> dataBiaya = [
      KeyValue(
        key: "Total",
        value: ToCurrency(penjualan.jumlahbayar.toString()),
      ),
      KeyValue(
        key: "Diterima",
        value: ToCurrency(penjualan.uangpelanggan.toString()),
      ),
      KeyValue(
        key: "Kembalian",
        value: ToCurrency(penjualan.kembalian.toString()),
      ),
    ];

    formattedList = formatKeyValueMultilineNew(dataBiaya);
    for (String line in formattedList) {
      struk.add({"text": line, "align": "left", "newLine": 1});
    }

    struk.add({"text": divider, "align": "center", "newLine": 1});
    struk.add({"text": footerKios, "align": "center", "newLine": 1});
    struk.add({"text": " ", "align": "center", "newLine": 1});
    struk.add({"text": " ", "align": "center", "newLine": 1});

    // Get printer info
    final printerName =
        await SecureStorageHelper.instance.getPrinterName() ?? "";
    final printerMac =
        await SecureStorageHelper.instance.getPrinterMacAddress() ?? "";

    debugPrint("PRINT STRUK PENJUALAN TO: $printerName - $printerMac");

    // Print
    await PrinterNativeHelper.printData(
      printerName: printerName,
      printerAddress: printerMac,
      items: struk,
    );
  }

  Widget _buildStatusCard(
    BuildContext context,
    PenjualanModel penjualan,
    DateTime waktuTrx,
  ) {
    final isSuccess = penjualan.status == 1;
    final statusText = isSuccess ? "Sukses" : "Refund";
    final statusColor = isSuccess ? context.success : context.destructive;

    return Card(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.isDarkMode ? stone[800] : stone[100],
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              border: Border(bottom: BorderSide(color: context.border)),
            ),
            padding: paddingCard,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(5),
                Text(
                  "$statusText • ${DateHelper.formatSimpleDate(waktuTrx)} • ${DateHelper.formatTime(waktuTrx)}",
                  style: context.bodyMedium.withWeight(FontWeight.w600),
                  textHeightBehavior: AppTextHeightBehavior.noPadding,
                ),
              ],
            ),
          ),
          _buildProductList(context),
          Container(
            decoration: BoxDecoration(
              color: context.isDarkMode ? stone[800] : stone[100],
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(12),
              ),
              border: Border(top: BorderSide(color: context.border)),
            ),
            padding: paddingCard,
            child: Row(
              children: [
                Text(
                  "Total",
                  style: context.bodyMedium.withWeight(FontWeight.w600),
                ),
                const Spacer(),
                Text(
                  "${ToCurrency(penjualan.jumlahbayar.toString())}",
                  style: context.bodyMedium.withWeight(FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(BuildContext context) {
    return BlocBuilder<KasirProvider, KasirState>(
      builder: (context, state) {
        if (state.apiGetDetailPenjualanStatus.isLoading) {
          return Padding(
            padding: paddingCard,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        final items = state.listPenjualanDetail;

        if (items.isEmpty) {
          return Padding(
            padding: paddingCard,
            child: Center(
              child: Text(
                "Tidak ada detail produk",
                style: context.bodyMedium.withColor(context.mutedForeground),
              ),
            ),
          );
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: paddingCard,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return _buildProductItem(context, item);
          },
        );
      },
    );
  }

  Widget _buildProductItem(
    BuildContext context,
    ListPenjualanDetailModel item,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: context.muted,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              MdiIcons.packageVariantClosed,
              size: 20,
              color: context.mutedForeground,
            ),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.namaproduk,
                  style: context.bodyMedium.withWeight(FontWeight.w600),
                ),
                const Gap(2),
                Text(
                  "${item.jumlah} ${item.satuan} × ${ToCurrency(item.hargajual.toString())}",
                  style: context.bodySmall.withColor(context.mutedForeground),
                ),
              ],
            ),
          ),
          const Gap(8),
          Text(
            ToCurrency(item.subtotalhargajual.toString()),
            style: context.bodyMedium.withWeight(FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    BuildContext context,
    PenjualanModel penjualan,
    int profit,
  ) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryItem(
              context,
              label: "Omzet",
              value: penjualan.jumlahbayar,
              icon: MdiIcons.trendingUp,
              iconColor: context.success,
            ),
          ),
          Container(width: 1, height: double.infinity, color: context.border),
          const Gap(15),
          Expanded(
            child: _buildSummaryItem(
              context,
              label: "Modal",
              value: profit,
              icon: LucideIcons.receipt,
              iconColor: context.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context, {
    required String label,
    required int value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              textHeightBehavior: AppTextHeightBehavior.noPadding,
              style: context.bodyMedium
                  .withColor(context.isDarkMode ? stone[700]! : stone[500]!)
                  .withWeight(FontWeight.bold),
            ),
            const Gap(5),
            Icon(icon, size: 14, color: iconColor),
          ],
        ),
        const Gap(5),
        Text(
          ToRupiah(value.toString()),
          style: context.pageTitle.withWeight(FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(BuildContext context, PenjualanModel penjualan) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _buildPaymentCard(
              context,
              label: "Diterima",
              value: penjualan.uangpelanggan,
              icon: MdiIcons.cashMultiple,
              iconColor: context.primary,
            ),
          ),
          const Gap(12),
          Expanded(
            child: _buildPaymentCard(
              context,
              label: "Kembalian",
              value: penjualan.kembalian,
              icon: LucideIcons.undo2,
              iconColor: context.warning,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(
    BuildContext context, {
    required String label,
    required int value,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: context.isDarkMode ? slate[600] : slate[200],
        borderRadius: BorderRadius.circular(12),
      ),
      padding: paddingCard,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.card,
              shape: BoxShape.circle,
              border: Border.all(color: context.border),
            ),
            padding: paddingCard,
            child: Icon(icon, size: 16, color: iconColor),
          ),
          const Gap(8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  textHeightBehavior: AppTextHeightBehavior.noPadding,
                  style: context.bodyMedium
                      .withColor(context.isDarkMode ? stone[700]! : stone[500]!)
                      .withWeight(FontWeight.bold),
                ),
                Text(
                  ToRupiah(value.toString()),
                  style: context.bodyLarge.withWeight(FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
