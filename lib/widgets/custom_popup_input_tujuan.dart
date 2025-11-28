import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum InputMethod {
  scan('scan', 'Scan QR Code', Icons.qr_code_scanner),
  voice('voice', 'Input Suara', Icons.mic),
  contact('contact', 'Pilih dari Kontak', Icons.contacts),
  paste('paste', 'Tempel dari Clipboard', Icons.paste);

  final String value;
  final String label;
  final IconData icon;

  const InputMethod(this.value, this.label, this.icon);
}

class CustomPopupInputTujuan extends StatelessWidget {
  final bool isContact;
  final bool isVoice;
  final bool isScan;
  final bool isTempel;
  final Function(String) onResult;

  const CustomPopupInputTujuan({
    super.key,
    this.isScan = false,
    this.isVoice = false,
    this.isContact = false,
    this.isTempel = false,
    required this.onResult,
  });

  List<InputMethod> get _availableMethods {
    final methods = <InputMethod>[];
    if (isScan) methods.add(InputMethod.scan);
    if (isVoice) methods.add(InputMethod.voice);
    if (isContact) methods.add(InputMethod.contact);
    if (isTempel) methods.add(InputMethod.paste);
    return methods;
  }

  Future<void> _handleSelection(BuildContext context, InputMethod method) async {
    switch (method) {
      case InputMethod.scan:
        _handleScanQR(context);
        break;
      case InputMethod.voice:
        _handleVoiceInput(context);
        break;
      case InputMethod.contact:
        _handleContactPicker(context);
        break;
      case InputMethod.paste:
        await _handlePasteFromClipboard(context);
        break;
    }
  }

  void _handleScanQR(BuildContext context) {
    // TODO: Implementasi scan QR
    onResult('08123456789'); // Example
  }

  void _handleVoiceInput(BuildContext context) {
    // TODO: Implementasi voice input
    onResult('08123456789'); // Example
  }

  void _handleContactPicker(BuildContext context) {
    // TODO: Implementasi contact picker
    onResult('08123456789'); // Example
  }

  Future<void> _handlePasteFromClipboard(BuildContext context) async {
    try {
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData?.text != null && clipboardData!.text!.isNotEmpty) {
        // Filter hanya angka
        final phoneNumber = clipboardData.text!.replaceAll(RegExp(r'[^0-9]'), '');
        if (phoneNumber.isNotEmpty) {
          onResult(phoneNumber);
        } else {
          _showSnackBar(context, 'Clipboard tidak berisi nomor telepon yang valid');
        }
      } else {
        _showSnackBar(context, 'Clipboard kosong');
      }
    } catch (e) {
      _showSnackBar(context, 'Gagal membaca clipboard');
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_availableMethods.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 18,
      width: 18,
      child: PopupMenuButton<InputMethod>(
        icon: const Icon(Icons.more_vert, size: 18),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.zero,
        menuPadding: EdgeInsets.zero,
        constraints: const BoxConstraints(
          minWidth: 170,
          maxWidth: 170,
        ),
        onSelected: (method) => _handleSelection(context, method),
        itemBuilder: (context) => _availableMethods
            .map((method) => _buildMenuItem(context, method))
            .toList(),
      ),
    );
  }

  PopupMenuItem<InputMethod> _buildMenuItem(
      BuildContext context,
      InputMethod method,
      ) {
    return PopupMenuItem<InputMethod>(
      value: method,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      child: Row(
        children: [
          Icon(method.icon, size: 14),
          const SizedBox(width: 8),
          Text(method.label, style: context.bodySmall),
        ],
      ),
    );
  }
}