import '../constants/app_strings.dart';

class Validators {
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.enterValidMobile;
    }

    // Remove any spaces or special characters
    final cleanNumber = value.replaceAll(RegExp(r'[^\d]'), '');
    
    if (cleanNumber.length != 10) {
      return AppStrings.mobileNumberLength;
    }

    // Check if it's a valid number (starts with digit 6-9 for Indian numbers)
    if (!RegExp(r'^[6-9]\d{9}$').hasMatch(cleanNumber)) {
      return AppStrings.enterValidMobile;
    }

    return null;
  }

  static String cleanMobileNumber(String mobileNumber) {
    return mobileNumber.replaceAll(RegExp(r'[^\d]'), '');
  }

  static String formatPhoneNumberWithCountryCode(String phoneNumber) {
    final cleaned = cleanMobileNumber(phoneNumber);
    return '+91$cleaned';
  }
}

