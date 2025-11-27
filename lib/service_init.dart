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
      await SecureStorageHelper.instance.saveToken(token);
      debugPrint('FCM Token: $token');
    }

    messaging.onTokenRefresh.listen((newToken) {
      SecureStorageHelper.instance.saveToken(newToken);
      debugPrint('Token refreshed: $newToken');
    });
  }

  static Future<void> _setupPermissions() async {
    final permissions = Platform.isAndroid
        ? [
            Permission.location,
            Permission.storage,
            Permission.camera,
            Permission.notification,
          ]
        : [
            Permission.locationWhenInUse,
            Permission.photos,
            Permission.camera,
            Permission.notification,
          ];

    final statuses = await permissions.request();

    // Handle permanently denied permissions
    for (final entry in statuses.entries) {
      if (entry.value.isPermanentlyDenied) {
        await openAppSettings();
        break;
      }
    }
  }
}
