import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();
  factory ConnectivityService() => _instance;
  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _isOfflineSheetShown = false;

  // Gunakan GlobalKey untuk akses Navigator yang aman
  GlobalKey<NavigatorState>? _navigatorKey;
  VoidCallback? _onOffline;
  VoidCallback? _onOnline;

  void init({
    required GlobalKey<NavigatorState> navigatorKey,
    VoidCallback? onOffline,
    VoidCallback? onOnline,
  }) {
    _navigatorKey = navigatorKey;
    _onOffline = onOffline;
    _onOnline = onOnline;
    _subscription?.cancel();
    _subscription = _connectivity.onConnectivityChanged.listen(_handleChange);
  }

  void _handleChange(List<ConnectivityResult> results) {
    final navigator = _navigatorKey?.currentState;
    if (navigator == null) return;

    final isOffline = results.isEmpty ||
        results.every((r) => r == ConnectivityResult.none);

    if (isOffline && !_isOfflineSheetShown) {
      _isOfflineSheetShown = true;
      _onOffline?.call();
    } else if (!isOffline && _isOfflineSheetShown) {
      _isOfflineSheetShown = false;
      _onOnline?.call();
      if (navigator.canPop()) navigator.pop();
    }
  }

  Future<bool> checkConnection() async {
    final results = await _connectivity.checkConnectivity();
    return results.isNotEmpty &&
        results.any((r) => r != ConnectivityResult.none);
  }

  Future<void> retryConnection() async {
    if (await checkConnection()) {
      _isOfflineSheetShown = false;
      _navigatorKey?.currentState?.pop();
    }
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}
