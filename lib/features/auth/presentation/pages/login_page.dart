// lib/features/auth/presentation/pages/login_page.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/utils/validators.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../provider/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

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
    return Scaffold(
      backgroundColor: AppColors.primaryBlue,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                
                // Title
                const Text(
                  AppStrings.login,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textWhite,
                  ),
                ),
                
                const SizedBox(height: 16),
                
                // Subtitle
                const Text(
                  AppStrings.letsStartWithMobile,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textWhite,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Mobile Input Field
                CustomTextField(
                  controller: _mobileController,
                  hintText: AppStrings.enterMobileNumber,
                  keyboardType: TextInputType.phone,
                  validator: Validators.validateMobileNumber,
                  maxLength: 10,
                ),
                
                const SizedBox(height: 24),
                
                // Send OTP Button
                Consumer<AuthProvider>(
                  builder: (context, authProvider, _) {
                    return CustomButton(
                      text: AppStrings.sendOtp,
                      onPressed: _handleSendOtp,
                      isLoading: authProvider.isLoading,
                    );
                  },
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
      ),
    );
  }
}