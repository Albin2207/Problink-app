import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../widgets/custom_button.dart';
import '../provider/auth_provider.dart';

class OtpVerificationPage extends StatefulWidget {
  const OtpVerificationPage({super.key});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _handleVerifyOtp() async {
    if (_otpController.text.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.enterOtp),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.verifyOtp(_otpController.text);

    if (success && mounted) {
      // Navigate to Dashboard
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/dashboard',
        (route) => false,
      );
    } else if (mounted && authProvider.errorMessage != null) {
      // Show error snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _handleResendOtp() async {
    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.resendOtp();
    
    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('OTP sent successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } else if (mounted && authProvider.errorMessage != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(authProvider.errorMessage!),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              
              // Title
              const Text(
                AppStrings.otp,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textWhite,
                ),
              ),
              
              const SizedBox(height: 16),
              
              // Subtitle
              const Text(
                AppStrings.otpSentMessage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textWhite,
                ),
              ),
              
              const SizedBox(height: 40),
              
              // OTP Input Fields
              Pinput(
                controller: _otpController,
                length: 6,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: AppColors.primaryGreen,
                      width: 2,
                    ),
                  ),
                ),
                submittedPinTheme: defaultPinTheme,
                showCursor: true,
                onCompleted: (pin) => _handleVerifyOtp(),
              ),
              
              const SizedBox(height: 24),
              
              // Verify Button
              Consumer<AuthProvider>(
                builder: (context, authProvider, _) {
                  return CustomButton(
                    text: AppStrings.verify,
                    onPressed: _handleVerifyOtp,
                    isLoading: authProvider.isLoading,
                  );
                },
              ),
              
              const SizedBox(height: 20),
              
              // Resend OTP
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.didNotReceiveOtp,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textWhite.withOpacity(0.8),
                    ),
                  ),
                  TextButton(
                    onPressed: _handleResendOtp,
                    child: const Text(
                      AppStrings.resendOtp,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textWhite,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              
              const Spacer(),
              
              // Policy Text
              Padding(
                padding: const EdgeInsets.only(bottom: 32.0),
                child: Text(
                  AppStrings.byAcceptingPolicy,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textWhite.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}