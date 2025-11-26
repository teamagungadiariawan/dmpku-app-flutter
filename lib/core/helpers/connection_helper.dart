import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dmpku/widgets/dialog/offline_dialog.dart';
import 'package:flutter/material.dart';

class ConnectivityService {
  static final ConnectivityService _instance = ConnectivityService._internal();

  factory ConnectivityService() => _instance;

  ConnectivityService._internal();

  final Connectivity _connectivity = Connectivity();
  StreamSubscription<List<ConnectivityResult>>? _subscription;

  bool _isOfflineSheetShown = false;
  BuildContext? _context;

  void init(BuildContext context) {
    _context = context;
    _subscription = _connectivity.onConnectivityChanged.listen(_handleChange);
  }

  void _handleChange(List<ConnectivityResult> results) {
    if (_context == null) return;

    // Cek apakah semua result adalah none (offline)
    final isOffline =
        results.isEmpty ||
        results.every((result) => result == ConnectivityResult.none);

    if (isOffline) {
      if (!_isOfflineSheetShown) {
        _isOfflineSheetShown = true;
        OfflineDialog.show(_context!, onRetry: () => _checkAndRetry());
      }
    } else {
      if (_isOfflineSheetShown) {
        _isOfflineSheetShown = false;
        Navigator.of(_context!).pop();
      }
    }
  }

  Future<void> _checkAndRetry() async {
    final results = await _connectivity.checkConnectivity();
    final isOnline =
        results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);

    if (isOnline && _context != null) {
      _isOfflineSheetShown = false;
      Navigator.of(_context!).pop();
    }
  }

  Future<bool> isOnline() async {
    final results = await _connectivity.checkConnectivity();
    return results.isNotEmpty &&
        results.any((result) => result != ConnectivityResult.none);
  }

  void dispose() {
    _subscription?.cancel();
  }
}
