import 'package:dmpku/core/helpers/device_info_helper.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrlApp(
  String? link, {
  LaunchMode mode = LaunchMode.inAppBrowserView,
}) async {
  if (link == null || link.isEmpty) return;

  try {
    await launchUrl(Uri.parse(link), mode: mode);
  } catch (e, stackTrace) {
    debugPrint('Error launching URL: $e');
    debugPrintStack(stackTrace: stackTrace);
  }
}

Future<void> openBantuanWaGuest() async {
  try {
    final text =
        'Halo, saya ingin bantuan mengenai aplikasi $appname ini.\nKendala : ';

    final waCs = await SecureStorageHelper.instance.getWacs();
    final link = '$waCs&text=${Uri.encodeComponent(text)}';

    debugPrint('link: $link');

    await launchUrlApp(link);
  } catch (e) {
    debugPrint('Error opening WhatsApp: $e');
    // atau pakai snackbar/dialog
    showErrorMessage('Gagal membuka WhatsApp');
  }
}

Future<void> openBantuanWa(BuildContext context) async {
  try {
    final user = getMemberProvider(context).state.profile;
    final text =
        'Halo, saya ingin bantuan mengenai aplikasi $appname ini.' +
        '\n\nNama: ${user.namamember}' +
        '\nKode member: ${user.kodemember}' +
        '\n\nKendala : ';

    final waCs = await SecureStorageHelper.instance.getWacs();
    final link = '$waCs&text=${Uri.encodeComponent(text)}';

    debugPrint('link: $link');

    await launchUrlApp(link);
  } catch (e) {
    debugPrint('Error opening WhatsApp: $e');
    // atau pakai snackbar/dialog
    showErrorMessage('Gagal membuka WhatsApp');
  }
}

Future<void> openMapByQuery(String query) async {
  final String encodedQuery = Uri.encodeComponent(query);
  final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedQuery');

  if (!await launchUrl(
    url,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('Gagal buka maps buat: $query');
  }
}