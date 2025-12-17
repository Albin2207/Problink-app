import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import 'package:delivery_app/widgets/bottom_nav_bar.dart';
import '../provider/qr_code_provider.dart';
import '../widgets/permission_denied_view.dart';
import '../widgets/scanned_result_view.dart';
import '../widgets/scanner_view.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  MobileScannerController? _controller;
  bool _hasPermission = false;
  bool _isCheckingPermission = true;

  @override
  void initState() {
    super.initState();
    _checkCameraPermission();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // Permission Logic
  Future<void> _checkCameraPermission() async {
    final status = await Permission.camera.status;
    
    if (status.isGranted) {
      _handlePermissionGranted();
    } else if (status.isDenied) {
      final result = await Permission.camera.request();
      if (result.isGranted) {
        _handlePermissionGranted();
      } else {
        _handlePermissionDenied();
      }
    } else {
      _handlePermissionDenied();
    }
  }

  void _handlePermissionGranted() {
    setState(() {
      _hasPermission = true;
      _isCheckingPermission = false;
    });
    _initializeScanner();
  }

  void _handlePermissionDenied() {
    setState(() {
      _hasPermission = false;
      _isCheckingPermission = false;
    });
  }

  // Scanner Logic
  void _initializeScanner() {
    if (_hasPermission) {
      _controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: CameraFacing.back,
      );
    }
  }

  void _handleBarcode(BarcodeCapture barcodeCapture) {
    final barcodes = barcodeCapture.barcodes;
    if (barcodes.isNotEmpty && barcodes.first.rawValue != null) {
      _controller?.stop();
      context.read<QrCodeProvider>().setScannedData(barcodes.first.rawValue!);
    }
  }

  void _startScanning() {
    if (_hasPermission && _controller != null) {
      _controller?.start();
      context.read<QrCodeProvider>().startScanning();
    } else {
      _checkCameraPermission();
    }
  }

  void _stopScanning() {
    _controller?.stop();
    context.read<QrCodeProvider>().stopScanning();
  }

  void _rescan() {
    context.read<QrCodeProvider>().clearScannedData();
    _startScanning();
  }

  void _handleBack() {
    _stopScanning();
    Navigator.pushReplacementNamed(context, '/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text(
          'QR Code Scanner',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: _handleBack,
        ),
      ),
      body: _buildBody(),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
    );
  }

  Widget _buildBody() {
    if (_isCheckingPermission) {
      return const Center(child: CircularProgressIndicator());
    }

    if (!_hasPermission) {
      return PermissionDeniedView(
        onGrantPermission: _checkCameraPermission,
      );
    }

    return Consumer<QrCodeProvider>(
      builder: (context, qrProvider, _) {
        if (qrProvider.scannedData != null) {
          return ScannedResultView(
            scannedData: qrProvider.scannedData!,
            onScanAgain: _rescan,
          );
        }

        return ScannerView(
          controller: _controller,
          isScanning: qrProvider.isScanning,
          onDetect: _handleBarcode,
          onStartScanning: _startScanning,
          onStopScanning: _stopScanning,
        );
      },
    );
  }
}