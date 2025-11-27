part of 'main.dart';

late final FlutterSecureStorage secureStorage;
late final PackageInfo packageInfo;
late final String deviceName;

const keyToken =
    "bDCMnwWOGQXk8s/IC4IiXuPWDfvwy/Wx4Y3jlAxSRCC8dsWgLdJjc1Ur6qerxA/8";
const keyLocation =
    "sLm05Q89J2YRKyJNGfzqIxvH/eFHuibnPNAphmos0l+8dsWgLdJjc1Ur6qerxA/8";

FlutterSecureStorage getSecureStorage() {
  if (Platform.isAndroid) {
    return FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    );
  } else if (Platform.isIOS) {
    return FlutterSecureStorage(
      iOptions: IOSOptions(
        accessibility: KeychainAccessibility.first_unlock_this_device,
      ),
    );
  }
  return FlutterSecureStorage();
}

void _setupSecureStorage() async {
  secureStorage = getSecureStorage();
}

void _setupEdgeToEdge() {
  // Enable Edge-to-Edge on Android 10+
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.yellow,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

Future<void> _setupFirebase() async {
  await Firebase.initializeApp();

  // Dapatkan FCM token
  String? token = await FirebaseMessaging.instance.getToken();
  debugPrint('FCM Token: $token');

  if (token != null) {
    secureStorage.write(key: keyToken, value: token);
  }

  FirebaseMessaging.instance.onTokenRefresh.listen((newToken) {
    debugPrint('Token refreshed: $newToken');
    secureStorage.write(key: keyToken, value: newToken);
  });
}

Future<void> _setupPackageInfo() async {
  packageInfo = await PackageInfo.fromPlatform();
}

Future<void> _setupPermissions() async {
  if (Platform.isAndroid) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.camera,
      Permission.notification,
    ].request();

    // Handle jika permission denied
    if (statuses[Permission.location]!.isDenied) {
      // Handle denied
    }

    if (statuses[Permission.location]!.isPermanentlyDenied) {
      // Arahkan ke settings
      await openAppSettings();
    }
  } else if (Platform.isIOS) {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.locationWhenInUse,
      Permission.photos,
      Permission.camera,
      Permission.notification,
    ].request();

    // Handle denied
  }
}

Future<void> _init() async {
  await _setupPermissions();
  _setupSecureStorage();
  _setupEdgeToEdge();
  await _setupPackageInfo();
  await _setupFirebase();

  var id = await getDeviceId2();

  debugPrint("DEVICE ID: $id");

}
