import 'package:flutter/foundation.dart';

class QrCodeProvider with ChangeNotifier {
  // State
  String? _scannedData;
  bool _isScanning = false;
  String? _errorMessage;

  // Getters
  String? get scannedData => _scannedData;
  bool get isScanning => _isScanning;
  String? get errorMessage => _errorMessage;

  // Set scanned data
  void setScannedData(String data) {
    _scannedData = data;
    _isScanning = false;
    _errorMessage = null;
    notifyListeners();
  }

  // Start scanning
  void startScanning() {
    _isScanning = true;
    _errorMessage = null;
    notifyListeners();
  }

  // Stop scanning
  void stopScanning() {
    _isScanning = false;
    notifyListeners();
  }

  // Set error
  void setError(String error) {
    _errorMessage = error;
    _isScanning = false;
    notifyListeners();
  }

  // Clear scanned data
  void clearScannedData() {
    _scannedData = null;
    _errorMessage = null;
    notifyListeners();
  }

  // Reset all
  void reset() {
    _scannedData = null;
    _isScanning = false;
    _errorMessage = null;
    notifyListeners();
  }
}

