import 'dart:io';

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
  }

  static Future<void> _setupFirebase() async {
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
