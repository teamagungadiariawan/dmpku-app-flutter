import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

const appshortname = "dmpku";
const appname = "DMPKU";

const _channel = MethodChannel('id.co.aviana.duniamasterpulsa_develop/device');

Future<String> getDeviceId() async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.id; // Android ID
    // atau androidInfo.androidId (deprecated tapi masih work)
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    return iosInfo.identifierForVendor ?? ''; // iOS UUID
  }

  return '';
}

/// Mendapatkan ANDROID_ID via MethodChannel (Settings.Secure.ANDROID_ID)
Future<String> getAndroidId() async {
  if (!Platform.isAndroid) return '';

  try {
    final String androidId = await _channel.invokeMethod('getAndroidId');
    return androidId;
  } on PlatformException catch (e) {
    print('Failed to get Android ID: ${e.message}');
    return '';
  }
}

Future<String> getDeviceId2() async {
  const androidIdPlugin = AndroidId();
  final androidId = await androidIdPlugin.getId();

  var id = '$appshortname:${androidId ?? '-'}';

  return id;
}

Future<String> getKeterangan() async {
  final deviceInfo = DeviceInfoPlugin();

  var keterangan = '';

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    var brand = androidInfo.brand ?? '';
    var model = androidInfo.model ?? '';
    var version = androidInfo.version.release ?? '';

    keterangan = '$brand $model - Android $version - $appname';
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    keterangan =
        '${iosInfo.name} ${iosInfo.model} - iOS ${iosInfo.systemVersion} - $appname';
  }

  if (keterangan.length > 100) {
    keterangan = keterangan.substring(0, 30);
  }

  return keterangan;
}

Future<String> getVersion() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}
