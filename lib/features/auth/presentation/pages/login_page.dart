import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/utils/responsive.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _handleSendOtp() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final phoneNumber = Validators.cleanMobileNumber(_mobileController.text);
      
      final success = await authProvider.sendOtp(phoneNumber);
      
      if (success && mounted) {
        // Navigate to OTP screen
        Navigator.pushNamed(context, '/otp');
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
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsive.screenWidth(context);
    final horizontalPadding = Responsive.horizontalPadding(context);
    final titleSize = Responsive.fontSize(context, 32);
    final subtitleSize = Responsive.fontSize(context, 16);
    final policySize = Responsive.fontSize(context, 12);
    
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    
                    // Title
                    Text(
                      AppStrings.login,
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textWhite,
                      ),
                    ),
                    
                    SizedBox(height: Responsive.spacing(context, 16)),
                    
                    // Subtitle
                    Text(
                      AppStrings.letsStartWithMobile,
                      style: TextStyle(
                        fontSize: subtitleSize,
                        color: AppColors.textWhite,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: Responsive.spacing(context, 40)),
                    
                    // Mobile Input Field
                    CustomTextField(
                      controller: _mobileController,
                      hintText: AppStrings.enterMobileNumber,
                      keyboardType: TextInputType.phone,
                      validator: Validators.validateMobileNumber,
                      maxLength: 10,
                    ),
                    
                    SizedBox(height: Responsive.spacing(context, 24)),
                    
                    // Send OTP Button
                    SizedBox(
                      width: double.infinity,
                      child: Consumer<AuthProvider>(
                        builder: (context, authProvider, _) {
                          return CustomButton(
                            text: AppStrings.sendOtp,
                            onPressed: _handleSendOtp,
                            isLoading: authProvider.isLoading,
                          );
                        },
                      ),
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
      ),
    );
  }
}