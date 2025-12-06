import 'package:permission_handler/permission_handler.dart';

// --- Request Methods ---

Future<void> requestPermissions() async {
  await requestLocationPermission();
  await requestCameraPermission();
  await requestStoragePermission();
  await requestNotificationPermission();
  await requestContactsPermission();
  await requestMicrophonePermission();
  await requestSpeechPermission();
}

Future<void> requestLocationPermission() async {
  await [
    Permission.location,
    Permission.locationAlways,
    Permission.locationWhenInUse,
  ].request();
}

Future<void> requestCameraPermission() async {
  await Permission.camera.request();
}

Future<void> requestStoragePermission() async {
  await [
    Permission.storage,
    Permission.mediaLibrary,
    Permission.photos,
    Permission.videos,
    Permission.audio,
  ].request();
}

Future<void> requestNotificationPermission() async {
  await Permission.notification.request();
}

Future<void> requestContactsPermission() async {
  await [Permission.contacts].request();
}

Future<void> requestMicrophonePermission() async {
  await Permission.microphone.request();
}

Future<void> requestSpeechPermission() async {
  await Permission.speech.request();
}

// --- Check Methods ---

Future<Map<Permission, PermissionStatus>> checkPermissions() async {
  final statuses = <Permission, PermissionStatus>{};
  statuses[Permission.location] = await checkLocationPermission();
  statuses[Permission.camera] = await checkCameraPermission();
  statuses[Permission.storage] = await checkStoragePermission();
  statuses[Permission.notification] = await checkNotificationPermission();
  statuses[Permission.contacts] = await checkContactsPermission();
  statuses[Permission.microphone] = await checkMicrophonePermission();
  statuses[Permission.speech] = await checkSpeechPermission();
  return statuses;
}

Future<PermissionStatus> checkLocationPermission() async {
  return Permission.location.status;
}

Future<PermissionStatus> checkCameraPermission() async {
  return Permission.camera.status;
}

Future<PermissionStatus> checkStoragePermission() async {
  return Permission.storage.status;
}

Future<PermissionStatus> checkNotificationPermission() async {
  return Permission.notification.status;
}

Future<PermissionStatus> checkContactsPermission() async {
  return Permission.contacts.status;
}

Future<PermissionStatus> checkMicrophonePermission() async {
  return Permission.microphone.status;
}

Future<PermissionStatus> checkSpeechPermission() async {
  return Permission.speech.status;
}