import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/app_colors.dart';

class ScannerView extends StatelessWidget {
  final MobileScannerController? controller;
  final bool isScanning;
  final Function(BarcodeCapture) onDetect;
  final VoidCallback onStartScanning;
  final VoidCallback onStopScanning;

  const ScannerView({
    super.key,
    required this.controller,
    required this.isScanning,
    required this.onDetect,
    required this.onStartScanning,
    required this.onStopScanning,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCameraPreview(),
        _buildScanningFrame(),
        _buildInstructions(),
        _buildActionButton(context),
      ],
    );
  }

  Widget _buildCameraPreview() {
    if (controller == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return MobileScanner(
      controller: controller!,
      onDetect: onDetect,
    );
  }

  Widget _buildScanningFrame() {
    return Center(
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.primaryGreen,
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Widget _buildInstructions() {
    return Positioned(
      bottom: 100,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Position QR code within the frame',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    return Positioned(
      bottom: 40,
      left: 24,
      right: 24,
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isScanning ? onStopScanning : onStartScanning,
          style: ElevatedButton.styleFrom(
            backgroundColor: isScanning ? Colors.red : AppColors.buttonBlue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(
              horizontal: 40,
              vertical: 16,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Text(
            isScanning ? 'Stop Scanning' : 'Start Scanning',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}