import 'package:flutter/material.dart';
import 'core/constants/app_colors.dart';
import 'features/auth/presentation/pages/login_page.dart';
import 'features/auth/presentation/pages/otp_verification_page.dart';
import 'features/dashboard/presentation/page/dashboard_screen.dart';
import 'features/delivery/presentation/page/delivery_screen.dart';
import 'features/qrcode/presentation/page/qr_code_screen.dart';


void main() {
  // TODO: Initialize Firebase
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delivery App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primaryBlue,
        scaffoldBackgroundColor: AppColors.backgroundColor,
        fontFamily: 'SF Pro',
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryBlue,
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/otp': (context) => const OtpVerificationPage(),
        '/dashboard': (context) => const DashboardPage(),
        '/delivery-list': (context) => const DeliveryListPage(),
        '/qr-scanner': (context) => const QrScannerPage(),
      },
    );
  }
}