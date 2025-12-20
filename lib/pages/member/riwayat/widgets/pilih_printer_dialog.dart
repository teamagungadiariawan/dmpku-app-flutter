import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/permission_helper.dart';
import 'package:dmpku/core/helpers/printer_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:permission_handler/permission_handler.dart';

class PilihPrinterDialog extends StatefulWidget {
  final String selectedMacAddress;
  final List<Map<String, String>> printers;

  const PilihPrinterDialog({
    super.key,
    required this.selectedMacAddress,
    required this.printers,
  });

  static Future<void> show(
    BuildContext context, {
    required String selectedMacAddress,
  }) async {
    var cekPermission = await checkBluetoothPermission();
    if (!cekPermission.isGranted) {
      await requestBluetoothPermission();
      cekPermission = await checkBluetoothPermission();
      if (!cekPermission.isGranted) {
        return;
      }
    }

    var selectedMacAddress =
        await SecureStorageHelper.instance.getPrinterMacAddress() ?? "";

    var printer = await PrinterNativeHelper.getPairedDevices();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar bisa atur tinggi
      useSafeArea: true,
      builder: (_) => PilihPrinterDialog(
        selectedMacAddress: selectedMacAddress,
        printers: printer,
      ),
    );
  }

  @override
  State<PilihPrinterDialog> createState() => _PilihPrinterDialogState();
}

class _PilihPrinterDialogState extends State<PilihPrinterDialog> {
  late String _selectedMacAddress = widget.selectedMacAddress;
  String _selectedPrinterName = '';
  late List<Map<String, String>> _printers = widget.printers;
  late bool _isLoading = false;
  final TextEditingController _searchController = TextEditingController();

  void _loadPrinters() async {
    setState(() {
      _isLoading = true;
    });
    var printers = await PrinterNativeHelper.getPairedDevices();
    setState(() {
      _printers = printers;
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterPrinters(String query) {
    final filteredPrinters = widget.printers.where((printer) {
      final name = printer['name']?.toLowerCase() ?? '';
      final address = printer['address']?.toLowerCase() ?? '';
      final searchQuery = query.toLowerCase();
      return name.contains(searchQuery) || address.contains(searchQuery);
    }).toList();

    setState(() {
      _printers = filteredPrinters;
    });
  }

  void _selectPrinter(String macAddress) {
    setState(() {
      _selectedMacAddress = macAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: bottomInset),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: context.border, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(10),
            TopDividerSheet(),
            Gap(15),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Padding(
                padding: paddingCard,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: context.isDarkMode ? stone[700] : stone[100],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(MdiIcons.printerSearch, size: 16),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pilih Printer Bluetooth',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Pilih printer bluetooth yang sudah terhubung pada perangkat Anda.',
                            style: context.captionRegular.withColor(
                              context.foreground,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Daftar Printer yang Tersedia",
                    style: context.bodyMedium.withWeight(FontWeight.w500),
                  ),
                  Spacer(),
                  CustomButton(
                    text: "Scan Ulang",
                    onPressed: () {
                      _loadPrinters();
                    },
                    isLoading: _isLoading,
                    height: 28,
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    variant: ButtonVariant.border,
                    backgroundColor: context.primary.withOpacity(0.2),
                    borderColor: context.primary,
                    textStyle: context.bodySmall
                        .withColor(context.primary)
                        .withWeight(FontWeight.w500),
                  ),
                ],
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildSearchField(context),
            ),
            Gap(10),
            SizedBox(height: 400, child: _buildPrinterList(context)),
            Gap(15),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: CustomButton(
                height: 32,
                padding: EdgeInsets.zero,
                width: double.infinity,
                iconPosition: IconPosition.end,
                icon: LucideIcons.arrowRight,
                text: "Simpan",
                onPressed: () {
                  SecureStorageHelper.instance.savePrinterMacAddress(
                    _selectedMacAddress,
                  );
                  SecureStorageHelper.instance.savePrinterName(
                    _selectedPrinterName,
                  );
                  pop();
                },
              ),
            ),

            Gap(15),
          ],
        ),
      ),
    );
  }

  Widget _buildPrinterList(BuildContext context) {
    if (_printers.isEmpty) {
      return Center(
        child: Text(
          'Tidak ada perangkat printer yang ditemukan.',
          style: context.bodyMedium.withColor(context.foreground),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 0),
      itemCount: _printers.length,
      itemBuilder: (context, index) {
        var item = _printers[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: item['address'] == _selectedMacAddress
                  ? context.primary
                  : context.border,
              width: 1,
            ),
          ),
          color: item['address'] == _selectedMacAddress
              ? context.primary.withOpacity(0.3)
              : null,
          child: InkWell(
            onTap: () {
              _selectPrinter(item['address'] ?? '');
              setState(() {
                _selectedPrinterName = item['name'] ?? '';
              });
            },
            borderRadius: BorderRadius.circular(8),
            child: Padding(
              padding: paddingCard,
              child: Row(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: context.isDarkMode ? stone[700] : stone[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      MdiIcons.printer,
                      size: 16,
                      color: context.primary,
                    ),
                  ),
                  Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['name'] ?? 'Nama Tidak Diketahui',
                          style: context.bodyMedium.withWeight(FontWeight.w500),
                        ),
                        Text(
                          item['address'] ?? 'Alamat Tidak Diketahui',
                          style: context.captionRegular.withColor(
                            context.foreground,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(8),
                  if (item['address'] == _selectedMacAddress)
                    Icon(
                      MdiIcons.checkDecagramOutline,
                      size: 20,
                      color: context.primary,
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Icon(LucideIcons.search, size: 18, color: context.foreground),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _searchController,
              onChanged: _filterPrinters,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Cari Perangkat Printer',
                suffixIcon: _searchController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          _searchController.clear();
                          _filterPrinters('');
                        },
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      )
                    : null,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }
}
