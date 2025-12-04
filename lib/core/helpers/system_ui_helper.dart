import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

SystemUiOverlayStyle getTransparentSystemUiOverlayStyle() {
  return const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}
SystemUiOverlayStyle getTransparentSystemUiOverlaDarkStyle() {
  return const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    systemNavigationBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
}

void setupEdgeToEdge() {
  // Enable Edge-to-Edge on Android 10+
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(getTransparentSystemUiOverlayStyle());
}
