import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtils {
  static final NetworkUtils _instance = NetworkUtils._();

  factory NetworkUtils() => _instance;

  NetworkUtils._();

  final Connectivity _connectivity = Connectivity();
  final StreamController<bool> _connectionStatusController =
      StreamController<bool>.broadcast();
  bool _isConnected = false;

  Stream<bool> get connectionStatus => _connectionStatusController.stream;

  bool get isConnected => _isConnected;

  Future<void> initialize() async {
    // Initial check
    _checkConnection();

    // Listen for connectivity changes
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _checkConnection();
    });
  }

  Future<void> _checkConnection() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _isConnected = result != ConnectivityResult.none;
      _connectionStatusController.add(_isConnected);
    } catch (e) {
      _isConnected = false;
      _connectionStatusController.add(false);
    }
  }

  void dispose() {
    _connectionStatusController.close();
  }
}
