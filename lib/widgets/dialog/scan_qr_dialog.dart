import 'dart:io';

import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class ScanQrDialog extends StatefulWidget {
  final Function(String)? onScanned; // jadikan final

  const ScanQrDialog({super.key, this.onScanned}); // tambah const

  static void show(BuildContext context, {Function(String)? onScanned}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // biar bisa atur tinggi
      useSafeArea: true,
      builder: (_) => ScanQrDialog(onScanned: onScanned),
    );
  }

  @override
  State<ScanQrDialog> createState() => _ScanQrDialogState();
}

class _ScanQrDialogState extends State<ScanQrDialog> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
            TopDividerSheet(),
            Gap(15),
            Card(
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
                      child: Icon(MdiIcons.qrcodeScan),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Scan Barcode/QR Code',
                            style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            'Scan barcode atau QR code untuk mendapatkan informasi dengan cepat.',
                            style: context.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gap(5),
            _buildQrView(context),
            Gap(10),
            CustomButton(
              height: 30,
              width: double.infinity,
              padding: EdgeInsets.zero,
              variant: ButtonVariant.destructive,
              text: "TUTUP",
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea =
        (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    // Tambahkan Container dengan ukuran eksplisit
    return SizedBox(
      height: scanArea + 100, // atau ukuran yang sesuai
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: QRView(
          key: qrKey,
          formatsAllowed: [
            BarcodeFormat.qrcode,
            BarcodeFormat.code128,
            BarcodeFormat.code39,
            BarcodeFormat.ean13,
            BarcodeFormat.ean8,
            BarcodeFormat.upcA,
            BarcodeFormat.upcE,
          ],
          onQRViewCreated: (controller) =>
              _onQRViewCreated(context, controller),
          overlay: QrScannerOverlayShape(
            borderColor: Colors.red,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
      ),
    );
  }

  void _onQRViewCreated(
    BuildContext context,
    QRViewController controller,
  ) async {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
      if (widget.onScanned != null && result != null) {
        debugPrint('Scanned QR Code: ${result!.code}');
        widget.onScanned!(result!.code ?? '');

        Future.delayed(const Duration(milliseconds: 500), () {
          Navigator.of(context).pop();
        });
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    debugPrint('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('no Permission')));
    }
  }
}
