import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pinput/pinput.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/responsive.dart';
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
    final horizontalPadding = Responsive.horizontalPadding(context);
    final titleSize = Responsive.fontSize(context, 32);
    final subtitleSize = Responsive.fontSize(context, 16);
    final policySize = Responsive.fontSize(context, 12);
    final otpSize = Responsive.isMobile(context) ? 50.0 : 60.0;
    final otpFontSize = Responsive.fontSize(context, 20);
    
    final defaultPinTheme = PinTheme(
      width: otpSize,
      height: otpSize,
      textStyle: TextStyle(
        fontSize: otpFontSize,
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
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: Responsive.maxContentWidth(context),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  
                  // Title
                  Text(
                    AppStrings.otp,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textWhite,
                    ),
                  ),
                  
                  SizedBox(height: Responsive.spacing(context, 16)),
                  
                  // Subtitle
                  Text(
                    AppStrings.otpSentMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: subtitleSize,
                      color: AppColors.textWhite,
                    ),
                  ),
                  
                  SizedBox(height: Responsive.spacing(context, 40)),
                  
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
                  
                  SizedBox(height: Responsive.spacing(context, 24)),
                  
                  // Verify Button
                  SizedBox(
                    width: double.infinity,
                    child: Consumer<AuthProvider>(
                      builder: (context, authProvider, _) {
                        return CustomButton(
                          text: AppStrings.verify,
                          onPressed: _handleVerifyOtp,
                          isLoading: authProvider.isLoading,
                        );
                      },
                    ),
                  ),
                  
                  SizedBox(height: Responsive.spacing(context, 20)),
                  
                  // Resend OTP
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.didNotReceiveOtp,
                        style: TextStyle(
                          fontSize: Responsive.fontSize(context, 14),
                          color: AppColors.textWhite.withOpacity(0.8),
                        ),
                      ),
                      TextButton(
                        onPressed: _handleResendOtp,
                        child: Text(
                          AppStrings.resendOtp,
                          style: TextStyle(
                            fontSize: Responsive.fontSize(context, 14),
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
                    padding: EdgeInsets.only(
                      bottom: Responsive.spacing(context, 32),
                    ),
                    child: Text(
                      AppStrings.byAcceptingPolicy,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: policySize,
                        color: AppColors.textWhite.withOpacity(0.8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}