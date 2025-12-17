import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors - Exact Figma colors
  static const Color primaryBlue = Color(0xFF0F65AE);
  static const Color primaryGreen = Color(0xFF16A249);
  
  // Background Colors
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color whiteBackground = Colors.white;
  
  // Card Colors - Exact Figma colors
  static const Color pendingBoxesCard = Color(0xFFF1846D);
  static const Color deliveredBoxesCard = Color(0xFF7BDAFE);
  static const Color pendingDeliveryCard = Color(0xFFF1846D);
  static const Color deliveryDoneCard = Color(0xFF16A249);
  static const Color kilometersCard = Color(0xFF8A38F5);
  
  // Text Colors
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textWhite = Colors.white;
  
  // Status Colors
  static const Color statusOutOfDelivery = Color(0x2916A249); // 16% opacity
  static const Color statusTextGreen = Color(0xFF00796B);
  
  // Button Colors
  static const Color buttonGreen = Color(0xFF16A249);
  static const Color buttonBlue = Color(0xFF0F65AE);
  
  // Gradient Colors for End Delivery Button
  static const Color gradientBlueStart = Color(0xFF004080);
  static const Color gradientBlueEnd = Color(0xFF0066CC);
  
  // Border Colors
  static const Color borderGrey = Color(0xFFE0E0E0);
  
  // Icon Colors
  static const Color iconGrey = Color(0xFF9E9E9E);
  static const Color iconBlue = Color(0xFF0F65AE);
}