import 'package:delivery_app/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_strings.dart';
import '../widgets/custom_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterValidEmail;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.enterValidEmail;
    }
    return null;
  }

  void _handleSendOtp() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement Firebase OTP logic
      setState(() => _isLoading = true);
      
      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        // Navigate to OTP screen
        Navigator.pushNamed(context, '/otp');
      });
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
                  AppStrings.letsStartWithEmail,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textWhite,
                  ),
                ),
                
                const SizedBox(height: 40),
                
                // Email Input Field
                CustomTextField(
                  controller: _emailController,
                  hintText: AppStrings.enterEmailId,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                
                const SizedBox(height: 24),
                
                // Send OTP Button
                CustomButton(
                  text: AppStrings.sendOtp,
                  onPressed: _handleSendOtp,
                  isLoading: _isLoading,
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