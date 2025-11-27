import 'dart:io';

import 'package:dmpku/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import '../apiconfig/server_exception.dart';

Future<String> getLocation() async {
  var result = '';
  const errLoc = ServerException(
    code: HttpStatus.forbidden,
    message: "Silakan nyalakan lokasi dulu ya!",
  );
  try {
    await Geolocator.requestPermission();
    final loc = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    result = "${loc.latitude},${loc.longitude}";

    await secureStorage.write(key: keyLocation, value: result);
  } catch (_) {}

  if (result.isEmpty) {
    throw errLoc;
  }

  debugPrint("RESULT $result");

  return result;
}
