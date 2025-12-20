import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

import 'core/helpers/storage_helper.dart';
import 'core/helpers/system_ui_helper.dart';

class ServiceInitializer {
  static Future<void> init() async {
    await Future.wait([_setupPermissions(), _setupFirebase()]);
    setupEdgeToEdge();

    var namaKios = await SecureStorageHelper.instance.getNamaKios() ?? '';
    var alamatKios = await SecureStorageHelper.instance.getAlamatKios() ?? '';
    var footerKios = await SecureStorageHelper.instance.getFooterKios() ?? '';

    if (namaKios.isEmpty) {
      await SecureStorageHelper.instance.saveNamaKios('DMPKU KIOS');
    }

    if (alamatKios.isEmpty) {
      await SecureStorageHelper.instance
          .saveAlamatKios('Jl. Contoh Alamat No.123, Kota Contoh');
    }

    if (footerKios.isEmpty) {
      await SecureStorageHelper.instance
          .saveFooterKios('Jual Pulsa,Paket Data,Token Listrik & Voucher Game');
    }
  }

  static Future<void> _setupFirebase() async {
    debugPrint('Initializing Firebase...');
    await Firebase.initializeApp();

    final messaging = FirebaseMessaging.instance;
    final token = await messaging.getToken();

    if (token != null) {
      SecureStorageHelper.instance.write(StorageKeys.tokenFcm, token);
      debugPrint('FCM Token: $token');
    }

    messaging.onTokenRefresh.listen((newToken) {
      SecureStorageHelper.instance.write(StorageKeys.tokenFcm, newToken);
      debugPrint('Token refreshed: $newToken');
    });
  }

  static Future<void> _setupPermissions() async {
    // Request notification permission at startup
    final status = await Permission.notification.request();

    if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}
